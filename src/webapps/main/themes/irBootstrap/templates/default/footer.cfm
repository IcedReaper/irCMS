<cfset footerNavigation = application.cms.navigation.getHierarchy(position='footer', language=request.language, parentNavigationId=0)>
<cfoutput>
    <footer>
        <div class="navbar navbar-inverse navbar-fixed-bottom">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="https://github.com/IcedReaper/irCMS">&copy; IcedReaper 2013</a>
                </div>
            	<div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
            	        <cfloop from="1" to="#footerNavigation.len()#" index="footerNavIndex">
            	        	<li><a href="#footerNavigation[footerNavIndex].sesLink#">#footerNavigation[footerNavIndex].linkname#</a></li>
            	        </cfloop>
        	       </ul>
                </div>
            </div>
        </div>
    </footer>
</cfoutput>