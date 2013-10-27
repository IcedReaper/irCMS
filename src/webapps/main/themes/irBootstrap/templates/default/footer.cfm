<cfset footerNavigation = application.cms.navigation.getHierarchy(position='footer', language=request.language, parentNavigationId=0)>
<cfoutput>
    <footer>
        <nav class="navbar navbar-inverse navbar-fixed-bottom">
            <div class="container">
                <header class="navbar-header">
                    <a class="navbar-brand" href="https://github.com/IcedReaper/irCMS">&copy; IcedReaper 2013</a>
                </header>
            	<section class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
            	        <cfloop from="1" to="#footerNavigation.len()#" index="footerNavIndex">
            	        	<li><a href="#footerNavigation[footerNavIndex].sesLink#">#footerNavigation[footerNavIndex].linkname#</a></li>
            	        </cfloop>
        	       </ul>
                </section>
            </div>
        </nav>
    </footer>
</cfoutput>