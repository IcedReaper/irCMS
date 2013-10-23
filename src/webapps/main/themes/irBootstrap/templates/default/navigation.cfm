<cfparam name="attributes.position" default="header">
<cfset headerNavigation = application.cms.navigation.getHierarchy(position=attributes.position, language=request.language, parentNavigationId=0)>
<cfoutput>
    <div class="navbar navbar-inverse navbar-static-top">
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
                <cfif request.userId eq 0>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">Login <b class="caret"></b></a>
                            <ul class="dropdown-menu" style="padding:15px;">
                                <form action="?login" method="post" autocomplete="false">
                                    <li>
                                        <div class="form-group">
                                            <input type="text" name="username" placeholder="username" class="form-control">
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                            <input type="password" name="password" placeholder="password" class="form-control">
                                        </div>
                                    </li>
                                    <li>
                                        <button type="submit" value="login" class="btn btn-success">Sign in</button>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <button type="submit" value="register" class="btn btn-default">Registrieren</button>
                                    </li>
                                </form>
                            </ul>
                        </li>
                    </ul>
                <cfelse>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">#request.actualUser.getUsername()# <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="">Userpanel</a></li>
                                <cfif application.security.permission.hasPermission(userId=session.userId, groupName='CMS', roleName='Reader')>
                                    <li><a href="/Admin">Zum Adminpanel</a></li>
                                </cfif>
                                <li><a href="?logout">Ausloggen</a></li>
                            </ul>
                        </li>
                    </ul>
                </cfif>
            </div>
        </div>
    </div>
</cfoutput>