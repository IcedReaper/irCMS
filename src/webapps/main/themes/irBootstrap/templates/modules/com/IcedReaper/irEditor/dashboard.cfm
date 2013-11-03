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
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset>
                    <legend>Veröffentlichte Versionen</legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th>Seitenname</th>
                                <th>SES Verlinkung</th>
                                <th>Status</th>
                                <th>Version</th>
                                <th>Letzte Änderung</th>
                                <th>&nbsp;</th>
                            </thead>
                            <tbody>
                                <cfmodule template="pageEntry.cfm" navigationId="1" pageName="Willkommen" sesLink="/" status="Online" version="1.0" lastChangeAt="#createDateTime(2013, 10, 30, 18, 32, 24)#" lastChangeBy="IcedReaper">
                            </tbody>
                        </table>
                    </div>
                </fieldset>
            </section>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset>
                    <legend>Versionen im Entwurfsstatus</legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th>Seitenname</th>
                                <th>SES Verlinkung</th>
                                <th>Status</th>
                                <th>Version</th>
                                <th>Letzte Änderung</th>
                                <th>&nbsp;</th>
                            </thead>
                            <tbody>
                                <cfmodule template="pageEntry.cfm" navigationId="1" pageName="Willkommen" sesLink="/" status="Rework" version="1.4" lastChangeAt="#createDateTime(2013, 10, 30, 20, 41, 24)#" lastChangeBy="IcedReaper">
                                <cfmodule template="pageEntry.cfm" navigationId="1" pageName="Willkommen" sesLink="/" status="Draft" version="1.3" lastChangeAt="#createDateTime(2013, 10, 30, 19, 22, 24)#" lastChangeBy="IcedReaper">
                            </tbody>
                        </table>
                    </div>
                </fieldset>
            </section>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset>
                    <legend>Versionen im Genehmigungsstatus</legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th>Seitenname</th>
                                <th>SES Verlinkung</th>
                                <th>Status</th>
                                <th>Version</th>
                                <th>Letzte Änderung</th>
                                <th>&nbsp;</th>
                            </thead>
                            <tbody>
                                <cfmodule template="pageEntry.cfm" navigationId="1" pageName="Willkommen" sesLink="/" status="Release Candidate" version="1.2" lastChangeAt="#createDateTime(2013, 10, 30, 18, 58, 24)#" lastChangeBy="IcedReaper">
                            </tbody>
                        </table>
                    </div>
                </fieldset>
            </section>
        </div>
    </div>
</cfoutput>