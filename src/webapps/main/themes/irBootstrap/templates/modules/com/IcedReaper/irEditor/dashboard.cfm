<cfset request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.pageTitle', language=request.language)>
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <cfmodule template="navigation.cfm" navigationId="0">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.title', language=request.language)#
                    <small>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.title', language=request.language)#</small>
                </h2>
            </header>
        </div>
    </div>
    <cfloop from="1" to="#attributes.dashboardData.len()#" index="statusIndex">
        <div class="row">
            <div class="col-md-12">
                <section class="widget">
                    <fieldset>
                        <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.pagesInStatus', language=request.language)# #attributes.dashboardData[statusIndex].statusName#</legend>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.pagename', language=request.language)#</th>
                                    <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.sesLink', language=request.language)#</th>
                                    <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.version', language=request.language)#</th>
                                    <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.lastChange', language=request.language)#</th>
                                    <th>&nbsp;</th>
                                </thead>
                                <tbody>
                                    <cfloop from="1" to="#attributes.dashboardData[statusIndex].pages.len()#" index="pageIndex">
                                        <tr>
                                            <td><a href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#">#attributes.dashboardData[statusIndex].pages[pageIndex].pageName#</a></td>
                                            <td><a href="#attributes.dashboardData[statusIndex].pages[pageIndex].sesLink#" target="_blank">#attributes.dashboardData[statusIndex].pages[pageIndex].sesLink#</a></td>
                                            <td>#attributes.dashboardData[statusIndex].pages[pageIndex].version#</td>
                                            <td>
                                                #dateFormat(attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeAt, "DD. MMM YYYY")#
                                                #timeFormat(attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeAt, "HH:MM:SS")#
                                                #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.changeBy', language=request.language)# <a href="/User/#attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#" target="_blank" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.changeByTitle', language=request.language)# #attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#">#attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#</a>
                                            </td>
                                            <td>
                                                <div class="btn-group pull-right">
                                                    <cfif attributes.dashboardData[statusIndex].editable>
                                                        <a class="btn btn-default" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.edit', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#"><span class="glyphicon glyphicon-pencil"></span></a>
                                                    </cfif>
                                                    <cfif attributes.dashboardData[statusIndex].readyToRelease>
                                                        <a class="btn btn-success" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.release', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Release"><span class="glyphicon glyphicon-ok"></span></a>
                                                    <cfelseif NOT attributes.dashboardData[statusIndex].online AND statusIndex NEQ attributes.dashboardData.len()>
                                                        <a class="btn btn-success" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.approve', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Approve"><span class="glyphicon glyphicon-ok"></span></a>
                                                        <cfif NOT attributes.dashboardData[statusIndex].editable>
                                                            <a class="btn btn-warning" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.decline', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Reject"><span class="glyphicon glyphicon-eye-close"></span></a>
														</cfif>
                                                    </cfif>
                                                    <cfif attributes.dashboardData[statusIndex].online>
                                                        <a class="btn btn-warning" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.revoke', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Revoke"><span class="glyphicon glyphicon-off"></span></a>
                                                    <cfelse>
                                                        <cfif attributes.dashboardData[statusIndex].editable>
                                                            <a class="btn btn-danger" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.delete', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Delete"><span class="glyphicon glyphicon-remove"></span></a>
                                                        <cfelseif false <!--- does the user have the permission to decline this version?--->>
                                                            <a class="btn btn-danger" title="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.dashboard.buttons.title.delete', language=request.language)#" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Delete"><span class="glyphicon glyphicon-remove"></span></a>
                                                        </cfif>
                                                    </cfif>
                                                </div>
                                            </td>
                                        </tr>
                                    </cfloop>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                </section>
            </div>
        </div>
	</cfloop>
</cfoutput>