<cfset request.headerNavigation = application.cms.navigation.getHierarchy(position='header', language=request.language)>
<cfoutput>
    <nav>
    	<ul>
	        <cfloop query="request.headerNavigation">
	        	<li><a href="#request.headerNavigation.sesLink#">#request.headerNavigation.linkname#</a></li>
	        </cfloop>
	    </ul>
    </nav>
</cfoutput>