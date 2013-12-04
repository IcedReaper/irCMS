<cfscript>
    request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.detail.pageTitle', language=request.language);
</cfscript>
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    <cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.headline'>
                    <small><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.subline'></small>
                </h2>
            </header>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <a class="btn btn-default" href="#attributes.sesLink#"><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.backToOverview'></a>
            </section>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset class="form-horizontal">
                    <legend><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.details.headline'></legend>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.details.errorType'></label>
                        <div class="col-lg-9">
                            <p class="form-control-static">#attributes.errorData.type#</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.details.date'></label>
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
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.errorDetail.#attributes.errorData.details[detailIndex].key#'></label>
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
                    <legend><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.stacktrace.headline'></legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th>##</th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.stacktrace.filename'></th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.stacktrace.line'></th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.stacktrace.code'></th>
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
                <a class="btn btn-default" href="#attributes.sesLink#"><cf_translation keyName='modules.com.IcedReaper.irErrorlog.detail.backToOverview'></a>
            </section>
        </div>
    </div>
</cfoutput>