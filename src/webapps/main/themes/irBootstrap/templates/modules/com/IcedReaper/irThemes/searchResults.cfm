<cfif isDefined("form.themeName")>
    <cfset request.pageTitle = "Themesuchergebnisse für '#form.themeName#'">
<cfelse>
    <cfset request.pageTitle = "Übersicht über die aktiven Themes">
</cfif>
<cfoutput>
    <cfif attributes.searchResults.len() GT 0>
        <div class="row">
            <div class="col-md-12">
                <header class="widget">
                    <h2><cfif isDefined("form.themeName")>Suchergebnisse<cfelse>Themeübersicht</cfif></h2>
                </header>
            </div>
        </div>
        <cfloop from="1" to="#attributes.searchResults.len()#" index="themeSearchIndex">
            <div class="row">
                <div class="col-md-12">
                    <section class="widget">
                        <div class="row">
                            <div class="col-md-2">
                                <section>
                                    <img src="#attributes.searchResults[themeSearchIndex].previewPic#" alt="Vorschau auf das Theme #attributes.searchResults[themeSearchIndex].themeName# ">
                                </section>
                            </div>
                            <div class="col-md-10">
                                <h2><a href="/Admin/Themes/#attributes.searchResults[themeSearchIndex].themeName#">#attributes.searchResults[themeSearchIndex].themeName#</a></h2>
                                <div class="row">
                                    <label class="col-lg-3 control-label">Wird benutzt von</label>
                                    <div class="col-lg-9">
                                        <p class="form-control-static">#attributes.searchResults[themeSearchIndex].inUseBy# Personen</p>
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