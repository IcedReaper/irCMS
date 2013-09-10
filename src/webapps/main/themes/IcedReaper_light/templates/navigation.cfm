<cfset request.headerNavigation = application.cms.navigation.getHierarchy(position='header')>
<cfoutput>
    <nav>
    	<ul>
	        <cfloop query="request.headerNavigation">
	        	<li><a href="#request.headerNavigation.ses#">#request.headerNavigation.linkname#</a></li>
	        </cfloop>
	    </ul>
    </nav>
</cfoutput>