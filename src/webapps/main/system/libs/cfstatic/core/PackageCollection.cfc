<cfcomponent output="false" extends="org.cfstatic.util.Base" hint="I am an abstract representation of a collection of packages (directories). I manage dealing with the collection as one, providing methods such as getting all the content of the packages in the correct order and getting the last modified date of the entire collection.">

<!--- properties --->
	<cfscript>
		_rootDirectory	= "";
		_rootUrl		= "";
		_minifiedUrl	= "";
		_fileType		= "";
		_packages		= StructNew();
		_ordered		= ArrayNew(1);
		_cacheBust      = true;
		_includePattern = ".*";
		_excludePattern = "";
	</cfscript>

<!--- constructor --->
	<cffunction name="init" access="public" returntype="org.cfstatic.core.PackageCollection" output="false" hint="I am the constructor">
		<cfargument name="rootDirectory"	type="string"  required="true" />
		<cfargument name="rootUrl"			type="string"  required="true" />
		<cfargument name="minifiedUrl"		type="string"  required="true" />
		<cfargument name="fileType"			type="string"  required="true" />
		<cfargument name="cacheBust"        type="boolean" required="true" />
		<cfargument name="includePattern"   type="string"  required="true" />
		<cfargument name="excludePattern"   type="string"  required="true" />
		<cfargument name="dependencies"     type="struct"  required="true" />
		<cfargument name="outputDir"        type="string"  required="true" />

		<cfscript>
			_setRootDirectory ( arguments.rootDirectory  );
			_setRootUrl       ( arguments.rootUrl        );
			_setMinifiedUrl   ( arguments.minifiedUrl    );
			_setFileType      ( arguments.fileType       );
			_setCacheBust     ( arguments.cacheBust      );
			_setIncludePattern( arguments.includePattern );
			_setExcludePattern( arguments.excludePattern );

			_loadFromFiles(
				  dependencies = arguments.dependencies
				, outputDir    = arguments.outputDir
			);

			return this;
		</cfscript>
	</cffunction>

<!--- public methods --->
	<cffunction name="getContent" access="public" returntype="string" output="false" hint="I return the file content of the entire collection, in the correct order.">
		<cfargument name="includeExternals" type="boolean" required="false" default="true" hint="Whether or not to download external dependencies and include them in the returned collection string" />

		<cfscript>
			var str			= $getStringBuffer();
			var packages	= getOrdered();
			var i			= 0;

			for(i=1; i LTE ArrayLen(packages); i++){
				if(arguments.includeExternals OR packages[i] NEQ 'external'){
					str.append( getPackage(packages[i]).getContent() );
				}
			}

			return str.toString();
		</cfscript>
	</cffunction>

	<cffunction name="renderIncludes" access="public" returntype="string" output="false" hint="I render the collection's html includes">
		<cfargument name="minification" type="string" required="true" hint="Mode of minification, this will effect how the includes are rendered. Either 'all', 'package', 'file' or 'none'" />
		<cfargument name="downloadExternals" type="boolean" required="true" hint="Whether or not external dependencies are internalized" />
		<cfargument name="includePackages" type="array" required="false" default="#ArrayNew(1)#" hint="Only include the packages in this array. If empty, include *all* packages." />
		<cfargument name="includeFiles" type="array" required="false" default="#ArrayNew(1)#" hint="Only include the files in this array. If empty, include *all* files." />
		<cfargument name="charset"      type="string" required="false" default="utf-8" />

		<cfscript>
			var str			=  $getStringBuffer();
			var included    = false;
			var minify		= "";
			var packages	= "";
			var i			= "";
			var src			= "";
			var media		= "";
			var ie			= "";

			// rendering will be different depending on the minification mode
			switch(arguments.minification){
				// minified at a level below the collection, loop through our packages
				// and hand rendering responsibility to them
				case 'none': case 'file': case 'package':
					packages = getOrdered();
					for(i=1; i LTE ArrayLen(packages); i++){

						// if this is the 'external' package and we're not downloading externals, force minification to none
						if(packages[i] EQ 'external' and not arguments.downloadExternals){
							minify = 'none';
						} else {
							minify = arguments.minification;
						}

						// add the package's rendering if it is not filtered out
						if( not ArrayLen(arguments.includePackages) or arguments.includePackages.contains(JavaCast('string', packages[i])) ){
							str.append( getPackage( packages[i] ).renderIncludes( minification = minify, includeFiles = arguments.includeFiles, charset=arguments.charset ) );
						}
					}
					break;

				// minified at the 'all' level (package collection)
				case 'all':
					src			= "#_getMinifiedUrl()#/#getMinifiedFileName()#";
					ie			= _getIeRestriction();

					// if we aren't downloading externals, render the external includes as unminified
					if(not arguments.downloadExternals and _packageExists('external')){
						str.append( getPackage('external').renderIncludes( minification='none' ));
					}

					// simple single include
					if(_getFileType() EQ 'css'){
						media = _getCssMedia();
						str.append( $renderCssInclude( src, media, ie, arguments.charset ) );
					} else {
						str.append( $renderJsInclude( src, ie, arguments.charset ) );
					}
					break;
			}

			return str.toString();
		</cfscript>
	</cffunction>

	<cffunction name="getPackage" access="public" returntype="Package" output="false" hint="I return the package object wihtin the collection with the given package name">
		<cfargument name="packageName" type="string" required="true" />

		<cfreturn _packages[arguments.packageName] />
	</cffunction>

	<cffunction name="getOrdered" access="public" returntype="array" output="false" hint="I return an array of package names that are in the correct order based on their dependencies">
		<cfscript>
			if( ArrayLen(_ordered) NEQ StructCount(_packages) ){
				_orderPackages();
			}

			return _ordered;
		</cfscript>
	</cffunction>

	<cffunction name="getMinifiedFileName" access="public" returntype="string" output="false" hint="I return the name of the file that this collection should use when being minified as a whole">
		<cfscript>
			var filename = "#_getFileType()#.min";

			if(_getCacheBust()){
				filename = $listAppend(filename, $generateCacheBuster( getLastModified() ), '.');
			}

			return $listAppend(filename, _getFileType(), '.');
		</cfscript>
		<cfreturn "" />
	</cffunction>

	<cffunction name="getLastModified" access="public" returntype="date" output="false" hint="I return the last modified date of the entire collection (based on the latest modified date of all the child packages)">
		<cfscript>
			var packages		= getOrdered();
			var fileModified	= "";
			var lastModified	= "1900-01-01";
			var i				= 0;

			for(i=1; i LTE ArrayLen(packages); i++){
				fileModified	= getPackage(packages[i]).getLastModified();
				if(lastModified LT fileModified){
					lastModified = fileModified;
				}
			}

			return lastModified;
		</cfscript>
	</cffunction>

<!--- private methods --->
	<cffunction name="_loadFromFiles" access="private" returntype="void" output="false" hint="I instantiate the collection by looking through all files in the collection's root directory">
		<cfargument name="dependencies" type="struct" required="true" />
		<cfargument name="outputDir"    type="string" required="true" />
		<cfscript>
			var files		= $directoryList( _getRootDirectory(), '*.#_getFileType()#' );
			var i			= 1;

			for(i=1; i lte files.recordCount; i++){
				if ( files.directory[i] neq arguments.outputDir ) {
					_addStaticFile(
						  path         = $normalizeUnixAndWindowsPaths( files.directory[i] & '/' & files.name[i] )
					    , dependencies = arguments.dependencies
					);
				}
			}
		</cfscript>
	</cffunction>

	<cffunction name="_addStaticFile" access="private" returntype="void" output="false" hint="I add a static file to the collection">
		<cfargument name="path"         type="string" required="true" />
		<cfargument name="dependencies" type="struct" required="true" />

		<cfscript>
			var packageName     = "";
			var package         = "";
			var dependencyArray = "";
			var dependency      = "";
			var dependencyPath  = "";
			var dependencyPkg   = "";
			var file            = "";
			var i               = "";

			if ( $shouldFileBeIncluded( arguments.path, _getIncludePattern(), _getExcludePattern() ) ){
				packageName = _getPackageNameFromPath( arguments.path );

				// get the package object (create if it doesn't exist already)
				if( not _packageExists( packageName ) ){
					_addPackage( packageName );
				}
				package = getPackage( packageName );

				// add the file to the package (if it doesn't exist already)
				if( not package.staticFileExists( arguments.path ) ){
					package.addStaticFile( arguments.path );
					file = package.getStaticFile( arguments.path );

					// ensure all dependencies are created as static files (including externals)
					dependencyArray	= file.getProperty( 'depends', ArrayNew(1), 'array' );
					if ( StructCount(dependencies) and StructKeyExists( dependencies.regular, path ) ) {
						dependencyArray = $ArrayMerge( dependencyArray, dependencies.regular[path] );
					}
					if ( StructCount(dependencies) and StructKeyExists( dependencies.conditional, path ) ) {
						file.setConditionalDependencies( dependencies.conditional[path] );
					}

					for(i=1; i LTE ArrayLen(dependencyArray); i++){
						dependency = dependencyArray[i];

						// calculate dependency path and package
						if ( $isUrl( dependency ) or _dependencyIsFullPath( dependency ) ) {
							dependencyPath = dependency;
						} else {
							dependencyPath = _getRootdirectory() & dependency;
						}
						dependencyPath	= Trim( dependencyPath );

						// add .css to .less dependencies
						if(ListLast(dependencyPath, '.') EQ 'less'){
							dependencyPath = dependencyPath & '.css';
						}

						dependencyPkg	= _getPackageNameFromPath( dependencyPath );

						// add the static file (yes, a call to this method - we want n depth recursion)
						try {
							_addStaticFile( dependencyPath, dependencies );
						} catch(any e) {
							// if the thrown error is one of ours, we should rethrow it (bubbling up)
							if(e.type EQ 'org.cfstatic.missingDependency'){
								$throw( argumentCollection = e );
							}
							// otherwise, throw our custom missing dependency error
							$throw(type="org.cfstatic.missingDependency", message="CFStatic Error: Could not find local dependency.", detail="The dependency, '#dependency#', could not be found or downloaded. CFStatic is expecting to find it at #dependencyPath#. The dependency is declared in '#arguments.path#'");
						}

						// add the static file object as a dependency to the file
						file.addDependency( getPackage( dependencyPkg ).getStaticFile( dependencyPath ) );
					}
				}
			}
		</cfscript>
	</cffunction>

	<cffunction name="_getPackageNameFromPath" access="private" returntype="string" output="false" hint="I calculate a unique package name given a full file path">
		<cfargument name="path"	type="string"	required="true" />

		<cfscript>
			var packageName = "";

			if( $isUrl( arguments.path) ){
				return 'external';
			}

			packageName = $listDeleteLast( ReplaceNoCase(arguments.path, _getRootdirectory(), ''), '/') & '/';
			if(Right(packageName, 1) NEQ '/'){
				packageName &= '/';
			}
			return packageName;
		</cfscript>
	</cffunction>

	<cffunction name="_newPackage" access="private" returntype="Package" output="false" hint="Instanciates a new package object (for adding to the collection)">
		<cfargument name="packageName" type="string" required="true" />

		<cfscript>
			var rootUrl = _getRootUrl();
			if(packageName NEQ 'external'){
				rootUrl = rootUrl & packageName;
			}

			return CreateObject('component', 'Package').init( arguments.packageName, rootUrl, _getMinifiedUrl(), _getFileType(), _getCacheBust() );
		</cfscript>
	</cffunction>

	<cffunction name="_addPackage" access="private" returntype="void" output="false" hint="Adds a package to the collection">
		<cfargument name="packageName" type="string" required="true" />

		<cfset _packages[arguments.packageName] = _newPackage( arguments.packageName ) />
	</cffunction>

	<cffunction name="_packageExists" access="private" returntype="boolean" output="false" hint="I return whether or not the given package exists within the collection">
		<cfargument name="packageName" type="string" required="true" />

		<cfreturn StructKeyExists(_packages, arguments.packageName) />
	</cffunction>

	<cffunction name="_orderPackages" access="private" returntype="void" output="false" hint="I calculate the order of packages, based on their dependencies. I cache this order locally.">
		<cfscript>
			var packages = StructKeyArray( _getPackages() );
			var i		 = "";

			ArraySort( packages, 'text' );
			for( i=1; i LTE ArrayLen(packages); i=i+1 ){
				_addPackageToOrderedList( packages[i] );
			}
		</cfscript>
	</cffunction>

	<cffunction name="_addPackageToOrderedList" access="private" returntype="void" output="false" hint="I am a utility method for ordering packages, adding individual packages, preceded by their dependencies to an array">
		<cfargument name="packageName" type="string" required="true" />

		<cfscript>
			var package			= getPackage( arguments.packageName );
			var dependencies	= package.getDependencies();
			var i				= 0;

			// first, add any *internal* dependencies
			ArraySort( dependencies, 'text' );

			for( i=1; i LTE ArrayLen(dependencies); i++ ){
				_addPackageToOrderedList( dependencies[i] );
			}

			// now add the file if not added already
			if( not ListFind(ArrayToList(_ordered), arguments.packageName) ){
				ArrayAppend( _ordered, arguments.packageName );
			}
		</cfscript>
	</cffunction>

	<cffunction name="_getIeRestriction" access="private" returntype="string" output="false" hint="I get the Internet explorer version 'restriction' for the entire package collection. All static files within a single package collection should have the same restriction (when minifiying all together), an exception will be thrown otherwise.">
		<cfscript>
			var packages		= getOrdered();
			var ieRestriction	= "";
			var i				= 0;

			if(ArrayLen(packages)){
				ieRestriction = getPackage( packages[1] ).getIeRestriction();
				for(i=2; i LTE ArrayLen(packages); i++){
					if(ieRestriction NEQ getPackage( packages[i] ).getIeRestriction()){
						$throw( type="cfstatic.PackageCollection.badConfig", message="There was an error compiling the #_getFileType()# min file, not all files define the same IE restriction." );
					}
				}
			}

			return ieRestriction;
		</cfscript>
	</cffunction>

	<cffunction name="_getCssMedia" access="private" returntype="string" output="false" hint="I get the target media of the css files entire package collection. All static files within a single package collections should have the same media (when minifiying all together), an exception will be thrown otherwise.">
		<cfscript>
			var packages		= getOrdered();
			var media	= "";
			var i		= 0;

			if(ArrayLen(packages)){
				media = getPackage( packages[1] ).getCssMedia();
				for(i=2; i LTE ArrayLen(packages); i++){
					if(media NEQ getPackage( packages[i] ).getCssMedia()){
						$throw( type="cfstatic.PackageCollection.badConfig", message="There was an error compiling the #_getFileType()# min file, not all files define the same CSS media." );
					}
				}
			}

			return media;
		</cfscript>
	</cffunction>

	<cffunction name="_dependencyIsFullPath" access="private" returntype="boolean" output="false">
		<cfargument name="dependency" type="string" required="true" />

		<cfscript>
			var rootDir = _getRootDirectory();

			return Left( dependency, Len( rootDir ) ) EQ rootDir;
		</cfscript>
	</cffunction>

<!--- accessors --->
	<cffunction name="_setRootDirectory" access="private" returntype="void" output="false">
		<cfargument name="rootDirectory" required="true" type="string" />
		<cfset _rootDirectory = arguments.rootDirectory />
	</cffunction>
	<cffunction name="_getRootDirectory" access="private" returntype="string" output="false">
		<cfreturn _rootDirectory />
	</cffunction>

	<cffunction name="_setRootUrl" access="private" returntype="void" output="false">
		<cfargument name="rootUrl" required="true" type="string" />
		<cfset _rootUrl = arguments.rootUrl />
	</cffunction>
	<cffunction name="_getRootUrl" access="private" returntype="string" output="false">
		<cfreturn _rootUrl />
	</cffunction>

	<cffunction name="_setMinifiedUrl" access="private" returntype="void" output="false">
		<cfargument name="minifiedUrl" required="true" type="string" />
		<cfset _minifiedUrl = arguments.minifiedUrl />
	</cffunction>
	<cffunction name="_getMinifiedUrl" access="private" returntype="string" output="false">
		<cfreturn _minifiedUrl />
	</cffunction>

	<cffunction name="_setFileType" access="private" returntype="void" output="false">
		<cfargument name="fileType" required="true" type="string" />
		<cfset _fileType = arguments.fileType />
	</cffunction>
	<cffunction name="_getFileType" access="private" returntype="string" output="false">
		<cfreturn _fileType />
	</cffunction>

	<cffunction name="_getPackages" access="private" returntype="struct" output="false">
		<cfreturn _packages />
	</cffunction>

	<cffunction name="_getCacheBust" access="private" returntype="boolean" output="false">
		<cfreturn _cacheBust>
	</cffunction>
	<cffunction name="_setCacheBust" access="private" returntype="void" output="false">
		<cfargument name="cacheBust" type="boolean" required="true" />
		<cfset _cacheBust = arguments.cacheBust />
	</cffunction>

	<cffunction name="_getIncludePattern" access="private" returntype="string" output="false">
		<cfreturn _includePattern>
	</cffunction>
	<cffunction name="_setIncludePattern" access="private" returntype="void" output="false">
		<cfargument name="includePattern" type="string" required="true" />
		<cfset _includePattern = arguments.includePattern />
	</cffunction>

	<cffunction name="_getExcludePattern" access="private" returntype="string" output="false">
		<cfreturn _excludePattern>
	</cffunction>
	<cffunction name="_setExcludePattern" access="private" returntype="void" output="false">
		<cfargument name="excludePattern" type="string" required="true" />
		<cfset _excludePattern = arguments.excludePattern />
	</cffunction>

</cfcomponent>