<cfset request.footerNavigation = application.cms.navigation.getHierarchy(position='footer', language=request.language)>
<cfoutput>
    <nav>
    	<ul>
	        <cfloop query="request.footerNavigation">
	        	<li><a href="#request.footerNavigation.sesLink#">#request.footerNavigation.linkname#</a></li>
	        </cfloop>
	    </ul>
    </nav>
</cfoutput>