﻿<cfscript>
	request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.overview.pageTitle', language=request.language);
</cfscript>
<cfoutput>
	<div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    <cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.headline'>
                    <small><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.subline'></small>
                </h2>
            </header>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <nav>
                <ul class="pagination">
                    <li <cfif attributes.page EQ 1>class="disabled"</cfif>><a href="#attributes.sesLink#/page/#attributes.page-1#">&laquo;</a></li>
                    <cfloop from="1" to="#attributes.pageCount#" index="errorPage">
                        <li <cfif errorPage EQ attributes.page>class="active"</cfif>><a href="#attributes.sesLink#/page/#errorPage#">#errorPage#</a></li>
                    </cfloop>
                    <li <cfif attributes.page EQ attributes.pageCount>class="disabled"</cfif>><a href="#attributes.sesLink#/page/#attributes.page+1#">&raquo;</a></li>
                </ul>
            </nav>
        </div>
    </div>
	<div class="row">
        <div class="col-md-12">
            <section class="widget">
                <fieldset>
                    <legend><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.table.headline'></legend>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.table.errorType'></th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.table.subType'></th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.table.templateName'></th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.table.line'></th>
                                <th><cf_translation keyName='modules.com.IcedReaper.irErrorlog.overview.table.date'></th>
                            </thead>
                            <tbody>
                                <cfloop from="1" to="#attributes.overview.len()#" index="errorIndex">
                                    <tr>
                                        <td><a href="#attributes.sesLink#/error/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].type#</a></td>
                                        <td><a href="#attributes.sesLink#/error/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].errorType#</a></td>
                                        <td><a href="#attributes.sesLink#/error/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].templateName#</a></td>
                                        <td><a href="#attributes.sesLink#/error/#attributes.overview[errorIndex].errorId#">#attributes.overview[errorIndex].line#</a></td>
                                        <td><a href="#attributes.sesLink#/error/#attributes.overview[errorIndex].errorId#">#dateFormat(attributes.overview[errorIndex].date, 'DD. MMM YYYY')# um #timeFormat(attributes.overview[errorIndex].date, 'HH:MM:SS')#</a></td>
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