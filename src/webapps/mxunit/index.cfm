
<cfparam name="url.print_js_resources" type="boolean" default="true" />
<cfparam name="url.toggledebug" type="boolean" default="true" />

<cfinclude template="resources/theme/header.cfm" />
<cftry>
	<h2>Welcome, ColdFusion User!</h2>

	<div  style="font-size:1.25em;color:#01010;text-decoration:italic">
		Hier entsteht die Testsuite für die Portale, Hompage etc.
	</div>

	<p><hr color="#eaeaea" noshade="true" size="1" /></p>

	<cfscript>
		//initialize the server and application scope variables of the portal web application
        include "/WWW/ext/init/setDefaultQueryCacheTime.cfm";
        include "/WWW/ext/init/setGlobalVars.cfm";
		
		//loop recursively through test directory
		results = createObject("component", "mxunit.runner.DirectoryTestSuite").run(expandPath("/TEST"), "TEST");
	</cfscript>
	
	<div>
		<cfoutput>
			#results.getResultsOutput('rawhtml')#
		</cfoutput>
	</div>

	<cfcatch type="any">
		<h2 class="error">Ooops!</h2>
		<p>
			There was a problem with running the <strong>installation test</strong>.
			The installation might be fine. Try to run the <a href="samples/samples.cfm">samples</a>. If it still
			doesn't work, <a href="http://groups.google.com/group/mxunit/">drop us a note</a>. We'll make sure you can get set up!
		</p>
		<cfoutput>
			<ul class="error">
				<li>
					<strong>Type:</strong><br />
					<code>#cfcatch.type#</code>
				</li>
				<li>
					<strong>Message:</strong><br />
					<code>#cfcatch.message#</code>
				</li>
				<li>
					<strong>Detail:</strong><br />
					<pre><code>#cfcatch.Detail#</code></pre>
				</li>
			</ul>
		</cfoutput>
		<cfdump var="#cfcatch#">
		<p>
			If the error is from not having write permissions most of the framework
			should still function. Some features will not function, such as
			making private functions public for testing.
		</p>
		<p>
			Also, make sure you or CFML engine has write access to this directory
			in order to run this installation test.
		</p>
	</cfcatch>
</cftry>

<cfinclude template="resources/theme/footer.cfm" />
