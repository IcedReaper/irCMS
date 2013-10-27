<cfset request.pageTitle = "Usersuchergebnisse für '#form.username#'">
<cfoutput>
    <cfif attributes.moduleData.searchResults.len() GT 0>
        <div class="row">
            <div class="col-md-12">
                <header class="widget">
                    <h2>
                        Suchergebnisse
                    </h2>
                </header>
            </div>
        </div>
        <cfloop from="1" to="#attributes.moduleData.searchResults.len()#" index="userSearchIndex">
            <div class="row">
                <div class="col-md-12">
                    <section class="widget">
                        <div class="row">
                            <div class="col-md-2">
                                <section>
                                    <img src="#attributes.moduleData.searchResults[userSearchIndex].avatar#" alt="#attributes.moduleData.searchResults[userSearchIndex].userName# Avatar">
                                </section>
                            </div>
                            <div class="col-md-10">
                                <h2><a href="/User/#attributes.moduleData.searchResults[userSearchIndex].userName#">#attributes.moduleData.searchResults[userSearchIndex].userName#</a></h2>
                                <div class="row">
                                    <label class="col-lg-3 control-label">Dabei seit</label>
                                    <div class="col-lg-9">
                                        <p class="form-control-static">#DateFormat(attributes.moduleData.searchResults[userSearchIndex].joinDate, "DD. MMM YYYY")# #TimeFormat(attributes.moduleData.searchResults[userSearchIndex].joinDate, "HH:MM")#</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-lg-3 control-label">Geschlecht</label>
                                    <div class="col-lg-9">
                                        <p class="form-control-static">#attributes.moduleData.searchResults[userSearchIndex].gender#</p>
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
                    Es wurden leider keine Ergebnisse für Ihre Suche gefunden.
                </div>
            </div>
        </div>
    </cfif>
</cfoutput>