<cfparam name="attributes.position" default="header">
<cfset headerNavigation = application.cms.navigation.getHierarchy(position=attributes.position, language=request.language, parentNavigationId=0)>

<cfoutput>
    <!---<nav>
    	<ul>
	        <cfloop from="1" to="#headerNavigation.len()#" index="headerNavIndex">
	        	<li>
                    <a href="#headerNavigation[headerNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].title#">#headerNavigation[headerNavIndex].linkname#</a>
                </li>
	        </cfloop>
	    </ul>
        <!--- display sub navigations --->
        <cfloop from="1" to="#headerNavigation.len()#" index="headerNavIndex">
            <cfif headerNavigation[headerNavIndex].children.len() GT 0>
                <nav class="subNavigation">
                    <ul>
                        <cfloop from="1" to="#headerNavigation[headerNavIndex].children.len()#" index="subNavIndex">
                            <li>
                                <a href="#headerNavigation[headerNavIndex].children[subNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].children[subNavIndex].title#">#headerNavigation[headerNavIndex].children[subNavIndex].linkname#</a>
                            </li>
                        </cfloop>
                    </ul>
                </nav>
            </cfif>
        </cfloop>
    </nav>--->
    <nav>
        <ul>
            <cfloop from="1" to="#headerNavigation.len()#" index="headerNavIndex">
                <li <cfif headerNavigation[headerNavIndex].children.len() GT 0>class="drpdown"</cfif>>
                    <a href="#headerNavigation[headerNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].title#"><i class="icon20 home"></i><span>#headerNavigation[headerNavIndex].linkname#</span></a>
                    <cfif headerNavigation[headerNavIndex].children.len() GT 0>
                        <ul class="drpcontent">
                            <cfloop from="1" to="#headerNavigation[headerNavIndex].children.len()#" index="subNavIndex">
                                <li>
                                    <a href="#headerNavigation[headerNavIndex].children[subNavIndex].sesLink#" title="#headerNavigation[headerNavIndex].children[subNavIndex].title#">#headerNavigation[headerNavIndex].children[subNavIndex].linkname#</a>
                                </li>
                            </cfloop>
                        </ul>
                    </cfif>
                </li>
            </cfloop>
        </ul>
    </nav>
</cfoutput>