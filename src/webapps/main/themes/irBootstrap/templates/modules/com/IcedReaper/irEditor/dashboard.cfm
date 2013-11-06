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
                                        <cfmodule template="pageEntry.cfm" navigationId = "#attributes.dashboardData[statusIndex].pages[pageIndex].navigationId#"
												                           pageName     = "#attributes.dashboardData[statusIndex].pages[pageIndex].pageName#"
                                                                           sesLink      = "#attributes.dashboardData[statusIndex].pages[pageIndex].sesLink#"
                                                                           version      = "#attributes.dashboardData[statusIndex].pages[pageIndex].version#"
                                                                           lastChangeAt = "#attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeAt#"
                                                                           lastChangeBy = "#attributes.dashboardData[statusIndex].pages[pageIndex].lastChangeBy#">
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