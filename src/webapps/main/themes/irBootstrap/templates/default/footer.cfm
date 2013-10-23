<cfset footerNavigation = application.cms.navigation.getHierarchy(position='footer', language=request.language, parentNavigationId=0)>
<cfoutput>
    <nav>
    	<ul>
	        <cfloop from="1" to="#footerNavigation.len()#" index="footerNavIndex">
	        	<li><a href="#footerNavigation[footerNavIndex].sesLink#">#footerNavigation[footerNavIndex].linkname#</a></li>
	        </cfloop>
	    </ul>
    </nav>
</cfoutput>