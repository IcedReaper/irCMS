<cfset footerNavigation = application.cms.navigation.getHierarchy(position='footer', language=request.language, parentNavigationId=0)>
<cfset headerNavigation = application.cms.navigation.getHierarchy(position='header', language=request.language, parentNavigationId=0)>
<cfoutput>
    <footer>
        <nav class="navbar navbar-inverse navbar-fixed-bottom">
            <div class="container">    
                <div class="row">
                    <div class="col-lg-12">
                        <cfloop from="1" to="#headerNavigation.len()#" index="headerNavIndex">
                            <div class="col-md-#(12/headerNavigation.len())#">
                                <ul class="list-unstyled">
                                    <li>#headerNavigation[headerNavIndex].linkname#</li>
                                    <li><a href="#headerNavigation[headerNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].title#">#headerNavigation[headerNavIndex].linkname#</a></li>
                                    <cfloop from="1" to="#headerNavigation[headerNavIndex].children.len()#" index="subNavIndex">
                                        <li>
                                            <a href="#headerNavigation[headerNavIndex].children[subNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].children[subNavIndex].title#">#headerNavigation[headerNavIndex].children[subNavIndex].linkname#</a>
                                        </li>
                                    </cfloop>
                                </ul>
                            </div>
                        </cfloop>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="col-md-8">
                            <cfloop from="1" to="#footerNavigation.len()#" index="footerNavIndex">
                                <a href="#footerNavigation[footerNavIndex].sesLink#">#footerNavigation[footerNavIndex].linkname#</a>
                            </cfloop>
                        </div>
                        <div class="col-md-4">
                           <p class="muted pull-right"><a class="navbar-brand" href="https://github.com/IcedReaper/irCMS">&copy; IcedReaper 2013 All rights reserved</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </footer>
</cfoutput>