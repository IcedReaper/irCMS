<cfif isDefined("form.username")>
    <cfset request.pageTitle = "#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.results.pageTitle', language=request.language)# '#form.username#'">
<cfelse>
    <cfset request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.overview.pageTitle', language=request.language)>
</cfif>
<cfoutput>
    <cfif attributes.searchResults.len() GT 0>
        <div class="row">
            <div class="col-md-12">
                <header class="widget">
                    <h2><cfif isDefined("form.username")><cf_translation keyName='modules.com.IcedReaper.irUser.search.results.headline'><cfelse><cf_translation keyName='modules.com.IcedReaper.irUser.search.overview.headline'></cfif></h2>
                </header>
            </div>
        </div>
        <cfloop from="1" to="#attributes.searchResults.len()#" index="userSearchIndex">
            <div class="row">
                <div class="col-md-12">
                    <section class="widget">
                        <div class="row">
                            <div class="col-md-2">
                                <section>
                                    <img src="#attributes.searchResults[userSearchIndex].avatar#" alt="#attributes.searchResults[userSearchIndex].userName# Avatar">
                                </section>
                            </div>
                            <div class="col-md-10">
                                <h2><a href="/User/#attributes.searchResults[userSearchIndex].userName#">#attributes.searchResults[userSearchIndex].userName#</a></h2>
                                <div class="row">
                                    <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irUser.search.activeSince'></label>
                                    <div class="col-lg-9">
                                        <p class="form-control-static">#DateFormat(attributes.searchResults[userSearchIndex].joinDate, "DD. MMM YYYY")# #TimeFormat(attributes.searchResults[userSearchIndex].joinDate, "HH:MM")#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irUser.search.gender'></label>
                                    <div class="col-lg-9">
                                        <p class="form-control-static">#attributes.searchResults[userSearchIndex].gender#</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </cfloop>
    <cfelse>
        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-info">
                    <cf_translation keyName='modules.com.IcedReaper.irUser.search.noResults'>
                </div>
            </div>
        </div>
    </cfif>
</cfoutput>