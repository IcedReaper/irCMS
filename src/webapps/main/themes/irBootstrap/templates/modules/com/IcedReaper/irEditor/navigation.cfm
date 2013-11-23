<cfoutput>
    <div class="nav navbar-inverse">
        <nav>
            <ul class="nav navbar-nav">
                <li><a class="<cfif attributes.navigationId EQ 0>active</cfif>" href="/Admin/Pages">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.navigation.dashboard', language=request.language)#</a></li>
                <cfif attributes.navigationId EQ 0>
                    <li><a href="/Admin/Pages/Neu">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.navigation.newPage', language=request.language)#</a></li>
                <cfelse>
                    <li><a href="/Admin/Pages/#attributes.navigationId#/Neue Majorversion">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.navigation.newMajorVersion', language=request.language)#</a></li>
                    <li><a href="/Admin/Pages/#attributes.navigationId#/Neue Minorversion/#attributes.version#">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.navigation.newMinorVersion', language=request.language)#</a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="##">
                            #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.navigation.versions', language=request.language)# <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <cfset versions = attributes.navigationCRUD.getVersions(navigationId=attributes.navigationId)>
                            <cfset lastVersion = 0>
                            <cfloop from="1" to="#versions.len()#" index="versionIndex">
                                <cfif lastVersion NEQ 0 AND lastVersion NEQ versions[versionIndex].major>
                                    <li class="divider"></li>
                                </cfif>
                                <li><a href="/Admin/Pages/#attributes.navigationId#/#versions[versionIndex].major#.#versions[versionIndex].minor#">#versions[versionIndex].major#.#versions[versionIndex].minor# (#versions[versionIndex].status#)</a></li>
                            </cfloop>
                        </ul>
                    </li>
                </cfif>
            </ul>
        </nav>
    </div>
</cfoutput>