<cfset request.pageTitle   = "irEditor Dashboard">
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
                    Dashboard
                    <small>irEditor</small>
                </h2>
            </header>
        </div>
    </div>
    <cfloop from="1" to="#attributes.dashboardData.len()#" index="statusIndex">
        <div class="row">
            <div class="col-md-12">
                <section class="widget">
                    <fieldset>
                        <legend>Seiten im Status: #attributes.dashboardData[statusIndex].statusName#</legend>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <th>Seitenname</th>
                                    <th>SES Verlinkung</th>
                                    <th>Version</th>
                                    <th>Letzte Änderung</th>
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
                                                von <a href="/User/#attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#" target="_blank" title="Profilseite von #attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#">#attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#</a>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <cfif attributes.dashboardData[statusIndex].editable>
                                                        <a class="btn btn-default" title="Diese Version des Artikels bearbeiten" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Bearbeiten"><span class="glyphicon glyphicon-pencil"></span></a>
                                                    </cfif>
                                                    <cfif attributes.dashboardData[statusIndex].readyToRelease>
                                                        <a class="btn btn-success" title="Diese Version Online nehmen" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Release"><span class="glyphicon glyphicon-ok"></span></a>
                                                    <cfelse>
                                                        <a class="btn btn-success" title="Diese Version freigeben" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Freigeben"><span class="glyphicon glyphicon-ok"></span></a>
                                                    </cfif>
                                                    <cfif attributes.dashboardData[statusIndex].online>
                                                        <a class="btn btn-warning" title="Die Version offline nehmen" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Offline nehmen"><span class="glyphicon glyphicon-off"></span></a>
                                                    <cfelse>
                                                        <cfif attributes.dashboardData[statusIndex].editable>
                                                            <a class="btn btn-danger" title="Diese Version löschen" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Löschen"><span class="glyphicon glyphicon-remove"></span></a>
                                                        <cfelseif false <!--- does the user have the permission to decline this version?--->>
                                                            <a class="btn btn-danger" title="Diese Version löschen" href="/Admin/Pages/#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#/#attributes.dashboardData[statusIndex].pages[pageIndex].version#/Löschen"><span class="glyphicon glyphicon-remove"></span></a>
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