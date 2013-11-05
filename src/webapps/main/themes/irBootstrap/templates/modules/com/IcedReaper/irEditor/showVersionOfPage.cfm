<cfoutput>
    <form action="" method="post" class="form-horizontal" role="form">
        <div class="row">
            <div class="col-md-12">
                <cfinclude template="navigation.cfm">
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <header class="widget">
                    <h2>#attributes.pageToShow.getLinkname()#<small>Version: #attributes.version#</small></h2>
                </header>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <aside class="widget">
                    <fieldset>
                        <legend>Optionen</legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Linkname</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="Linkname" value="#attributes.pageToShow.getLinkname()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getLinkname()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">SES Link</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="sesLink" value="#attributes.pageToShow.getSesLink()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getSesLink()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Entities</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="(.*)" <cfif attributes.pageToShow.getRegExp() != ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Ja">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="" <cfif attributes.pageToShow.getRegExp() == ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Nein">
                                            </div>
                                        </div>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static"><cfif attributes.pageToShow.getRegExp() != ''>Ja<cfelse>Nein</cfif></p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Modul</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="moduleId" value="" <cfif attributes.pageToShow.getModuleId() == ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Kein Modul">
                                            </div>
                                        </div>
                                    </div>
                                    <cfset installedModules = application.cms.moduleCRUD.getActive()>
                                    <cfloop from="1" to="#installedModules.len()#" index="moduleIndex">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <input type="radio" name="moduleId" value="#installedModules[moduleIndex].id#" <cfif attributes.pageToShow.getModuleId() == installedModules[moduleIndex].id>checked="checked"</cfif>>
                                                    </span>
                                                    <input type="text" class="form-control" disabled="disabled" value="#installedModules[moduleIndex].name#">
                                                </div>
                                            </div>
                                        </div>
                                    </cfloop>
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getModuleName()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Moduloptionen</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="Title" value="#attributes.pageToShow.getModuleAttributes()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getModuleAttributes()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Titel</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="Title" value="#attributes.pageToShow.getTitle()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getTitle()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Beschreibung</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="description" value="#attributes.pageToShow.getDescription()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getDescription()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Schlüsselwörter</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="keywords" value="#attributes.pageToShow.getKeywords()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getKeywords()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">Versionskommentar</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="versionComment" value="#attributes.pageToShow.getVersionComment()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getKeywords()#</p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>
                </aside>
            </div>
        </div>

        <cfif attributes.pageToShow.isEditable()>
            <div class="row">
                <div class="col-md-12">
                    <aside class="widget">
                        <fieldset>
                            <legend>Editor optionen</legend>
                            <div class="btn-group">
                                <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-align-left"></span></button>
                                <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-align-center"></span></button>
                                <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-align-right"></span></button>
                                <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-align-justify"></span></button>
                            </div>
                        </fieldset>
                    </aside>
                </div>
            </div>
        </cfif>

        <div class="content <cfif attributes.pageToShow.isEditable()>editable</cfif>">
            #attributes.pageToShow.getContent()#
        </div>
    </form>
</cfoutput>