<cfoutput>
    <div class="nav navbar-inverse">
        <nav>
            <ul class="nav navbar-nav">
                <li><a class="<cfif attributes.navigationId EQ 0>active</cfif>" href="/Admin/Pages"><cf_translation keyName='modules.com.IcedReaper.irEditor.navigation.dashboard'></a></li>
                <cfif attributes.navigationId EQ 0>
                    <li><a href="/Admin/Pages/newPage"><cf_translation keyName='modules.com.IcedReaper.irEditor.navigation.newPage'></a></li>
                    <li><a href="/Admin/Pages/sort"><cf_translation keyName='modules.com.IcedReaper.irEditor.navigation.sort'></a></li>
                <cfelse>
                    <li><a href="/Admin/Pages/#attributes.navigationId#/newMajor"><cf_translation keyName='modules.com.IcedReaper.irEditor.navigation.newMajorVersion'></a></li>
                    <li><a href="/Admin/Pages/#attributes.navigationId#/newMinor/#attributes.majorVersion#"><cf_translation keyName='modules.com.IcedReaper.irEditor.navigation.newMinorVersion'></a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="##">
                            <cf_translation keyName='modules.com.IcedReaper.irEditor.navigation.versions'> <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <cfset versions = attributes.navigationCRUD.getVersions(navigationId=attributes.navigationId)>
                            <cfset lastVersion = 0>
                            <cfloop from="1" to="#versions.len()#" index="versionIndex">
                                <cfif lastVersion NEQ 0 AND lastVersion NEQ versions[versionIndex].majorVersion>
                                    <li class="divider"></li>
                                </cfif>
                                <li><a href="/Admin/Pages/#attributes.navigationId#/#versions[versionIndex].majorVersion#/#versions[versionIndex].minorVersion#">#versions[versionIndex].majorVersion#.#versions[versionIndex].minorVersion# (#versions[versionIndex].status#)</a></li>
                            </cfloop>
                        </ul>
                    </li>
                </cfif>
            </ul>
        </nav>
    </div>
</cfoutput>