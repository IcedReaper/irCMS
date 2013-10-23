<cfparam name="attributes.position" default="header">
<cfset headerNavigation = application.cms.navigation.getHierarchy(position=attributes.position, language=request.language, parentNavigationId=0)>
<cfoutput>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">irCMS</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <cfloop from="1" to="#headerNavigation.len()#" index="headerNavIndex">
                        <li class="<cfif headerNavigation[headerNavIndex].sesLink eq request.sesLink>class=active</cfif> <cfif headerNavigation[headerNavIndex].children.len() GT 0>dropdown</cfif>">
                            <a href="#headerNavigation[headerNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].title#" <cfif headerNavigation[headerNavIndex].children.len() GT 0>class="dropdown-toggle" data-toggle="dropdown"</cfif>>#headerNavigation[headerNavIndex].linkname# <cfif headerNavigation[headerNavIndex].children.len() GT 0><b class="caret"></b></cfif></a>
                            <ul class="dropdown-menu">
                                <li><a href="#headerNavigation[headerNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].title#">#headerNavigation[headerNavIndex].linkname#</a></li>
                                <cfloop from="1" to="#headerNavigation[headerNavIndex].children.len()#" index="subNavIndex">
                                    <li>
                                        <a href="#headerNavigation[headerNavIndex].children[subNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].children[subNavIndex].title#">#headerNavigation[headerNavIndex].children[subNavIndex].linkname#</a>
                                    </li>
                                </cfloop>
                            </ul>
                        </li>
                    </cfloop>
                </ul>
                <form class="navbar-form navbar-right">
                    <div class="form-group">
                        <input type="text" placeholder="Email" class="form-control">
                    </div>
                    <div class="form-group">
                        <input type="password" placeholder="Password" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-success">Sign in</button>
                </form>
            </div>
        </div>
    </div>
</cfoutput>