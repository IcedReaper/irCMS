<cfscript>
    request.pageTitle = "Details zum Fehler";
</cfscript>
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    Errorlog
                    <small>Details</small>
                </h2>
            </header>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <a class="btn btn-default" href="#attributes.sesLink#">Zurück zur Übersicht</a>
            </section>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset class="form-horizontal">
                    <legend>Fehlerdetails</legend>
                    <div class="form-group">
                        <label class="col-lg-3 control-label">Fehlerart</label>
                        <div class="col-lg-9">
                            <p class="form-control-static">#attributes.errorData.type#</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label">Fehlerdatum</label>
                        <div class="col-lg-9">
                            <p class="form-control-static">#dateFormat(attributes.errorData.date, 'DD. MMM YYYY')# um #timeFormat(attributes.errorData.date, 'HH:MM:SS')#</p>
                        </div>
                    </div>
                </fieldset>
            </section>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset class="form-horizontal">
                    <legend>Details</legend>
                    <cfloop from="1" to="#attributes.errorData.details.len()#" index="detailIndex">
                        <div class="form-group">
                            <label class="col-lg-3 control-label">#attributes.errorData.details[detailIndex].key#</label>
                            <div class="col-lg-9">
                                <cfif attributes.errorData.details[detailIndex].key EQ 'sql'>
									<p class="form-control-static"><pre>#reReplace(attributes.errorData.details[detailIndex].value, '\s+', ' ', 'ALL')#</pre></p>
                                <cfelse>
									<p class="form-control-static">#attributes.errorData.details[detailIndex].value#</p>
								</cfif>
                            </div>
                        </div>
                    </cfloop>
                </fieldset>
            </section>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset>
                    <legend>Stacktrace</legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th>##</th>
                                <th>Dateiname</th>
                                <th>Linie</th>
                                <th>Code</th>
                            </thead>
                            <tbody>
                                <cfloop from="1" to="#attributes.errorData.stacktrace.len()#" index="stacktraceIndex">
                                    <tr>
                                        <td>#attributes.errorData.stacktrace[stacktraceIndex].chainposition#</td>
                                        <td>#attributes.errorData.stacktrace[stacktraceIndex].templateName#</td>
                                        <td>#attributes.errorData.stacktrace[stacktraceIndex].line#</td>
                                        <td><pre>#replace(attributes.errorData.stacktrace[stacktraceIndex].codeHtml, '<br>', '', 'ALL')#</pre></td>
                                    </tr>
                                </cfloop>
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
                <a class="btn btn-default" href="#attributes.sesLink#">Zurück zur Übersicht</a>
            </section>
        </div>
    </div>
</cfoutput>