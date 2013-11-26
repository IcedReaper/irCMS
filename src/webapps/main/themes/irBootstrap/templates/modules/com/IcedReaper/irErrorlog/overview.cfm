﻿<cfscript>
	request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.pageTitle', language=request.language);
</cfscript>
<cfoutput>
	<div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.headline', language=request.language)#
                    <small>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.subline', language=request.language)#</small>
                </h2>
            </header>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <nav>
                <ul class="pagination">
                    <li <cfif attributes.page EQ 1>class="disabled"</cfif>><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.page', language=request.language)#/#attributes.page-1#">&laquo;</a></li>
                    <cfloop from="1" to="#attributes.pageCount#" index="errorPage">
                        <li <cfif errorPage EQ attributes.page>class="active"</cfif>><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.page', language=request.language)#/#errorPage#">#errorPage#</a></li>
                    </cfloop>
                    <li <cfif attributes.page EQ attributes.pageCount>class="disabled"</cfif>><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.page', language=request.language)#/#attributes.page+1#">&raquo;</a></li>
                </ul>
            </nav>
        </div>
    </div>
	<div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset>
                    <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.table.headline', language=request.language)#</legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.table.errorType', language=request.language)#</th>
                                <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.table.subType', language=request.language)#</th>
                                <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.table.templateName', language=request.language)#</th>
                                <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.table.line', language=request.language)#</th>
                                <th>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.table.date', language=request.language)#</th>
                            </thead>
                            <tbody>
                                <cfloop from="1" to="#attributes.overview.len()#" index="errorIndex">
                                    <tr>
                                        <td><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.error', language=request.language)#/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].type#</a></td>
                                        <td><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.error', language=request.language)#/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].errorType#</a></td>
                                        <td><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.error', language=request.language)#/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].templateName#</a></td>
                                        <td><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.error', language=request.language)#/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].line#</a></td>
                                        <td><a href="#attributes.sesLink#/#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.error', language=request.language)#/#attributes.overview[errorIndex].errorId#">#dateFormat(attributes.overview[errorIndex].date, 'DD. MMM YYYY')# um #timeFormat(attributes.overview[errorIndex].date, 'HH:MM:SS')#</a></td>
                                    </tr>
	                            </cfloop>
                            </tbody>
                        </table>
                    </div>
                </fieldset>
            </section>
        </div>
    </div>
</cfoutput>