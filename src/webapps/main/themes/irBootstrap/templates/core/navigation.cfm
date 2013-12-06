<cfparam name="attributes.position" default="header">
<cfset headerNavigation = application.cms.navigationCRUD.getHierarchy(position=attributes.position, language=request.language, parentNavigationId=0)>
<cfoutput>
    <header>
        <nav class="navbar navbar-inverse navbar-static-top">
            <div class="container">
                <header class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/"><cf_translation keyName='core.navigation.pageName'></a>
                </header>
                <section class="navbar-collapse collapse">
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
                    <cfif NOT request.isLoggedIn>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="##" class="dropdown-toggle" data-toggle="dropdown"><cf_translation keyName='core.navigation.login.headline'> <b class="caret"></b></a>
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
                                            <button type="submit" value="login" class="btn btn-success"><cf_translation keyName='core.navigation.login.login'></button>
                                        </li>
                                    </form>
                                    <li class="divider"></li>
                                    <li>
                                        <a type="submit" value="register" class="btn btn-default" href="/User/register"><cf_translation keyName='core.navigation.login.register'></a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    <cfelse>
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="##" class="dropdown-toggle" data-toggle="dropdown">
                                    <cfif request.actualUser.getAvatar() NEQ "">
                                        <img src="#request.actualUser.getAvatar()#" class="avatar">
                                    </cfif>
                                    #session.userName# <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="/User/#session.userName#"><cf_translation keyName='core.navigation.login.userPanel'></a></li>
                                    <cfif application.security.permission.hasPermission(userName=session.userName, groupName='CMS', roleName='Reader')>
                                        <li><a href="/Admin"><cf_translation keyName='core.navigation.login.toAdminPanel'></a></li>
                                    </cfif>
                                    <li><a href="?logout"><cf_translation keyName='core.navigation.login.logout'></a></li>
                                </ul>
                            </li>
                        </ul>
                    </cfif>
                </section>
            </div>
        </nav>
    </header>
</cfoutput>