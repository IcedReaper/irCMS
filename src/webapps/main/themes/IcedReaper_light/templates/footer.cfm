<cfset request.footerNavigation = application.cms.navigation.getHierarchy(position='footer')>
<cfoutput>
    <nav>
    	<ul>
	        <cfloop query="request.footerNavigation">
	        	<li><a href="#request.footerNavigation.ses#">#request.footerNavigation.linkname#</a></li>
	        </cfloop>
	    </ul>
    </nav>
</cfoutput>