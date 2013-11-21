<cfscript>
    request.pageTitle = "Bearbeiten der Seite #attributes.pageToShow.getSesLink()#";
    application.themes.irBootstrap.cfstatic.include('/js/modules/com/IcedReaper/irEditor/')
                                           .include('/css/modules/com/IcedReaper/irEditor/');
    
    application.tools.wrapper.htmlHead('<script src="/themes/irBootstrap/js/vendor/tinyMce/jquery.tinymce.min.js" charset="utf-8"></script>');
    application.tools.wrapper.htmlHead('<script src="/themes/irBootstrap/js/vendor/tinyMce/tinymce.min.js" charset="utf-8"></script>');
</cfscript>
<cfoutput>
    <form action="#request.sesLink#" method="post" class="form-horizontal" role="form" id="irEditor">
        <input type="hidden" name="content">
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
                <section class="widget">
                    <cfif isDefined('attributes.contentUpdate')>
                        <cfif attributes.contentUpdate.success>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-success">
                                        Die Seite wurde erfolgreich gespeichert
                                    </div>
                                </div>
                            </div>
                        <cfelse>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-danger">
                                        Während des Speicherns konnte ein oder mehrere Felder nicht korrekt validiert werden.<br>
                                        Bitte gucken Sie sich unten die rot markierten Felder an und korrigieren Sie diese.
                                    </div>
                                </div>
                            </div>
                        </cfif>
                    </cfif>
                    <fieldset>
                        <legend>Pflichtangaben</legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Aktueller Status</label>
                            <div class="col-lg-9">
                                <p class="form-control-static">#attributes.pageToShow.getStatusName()#</p>
                            </div>
                        </div>
                        
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.linkName>has-error</cfif>">
                            <label class="col-lg-3 control-label">Linkname</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="Linkname" value="#attributes.pageToShow.getLinkname()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getLinkname()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.sesLink>has-error</cfif>">
                            <label class="col-lg-3 control-label">SES Link</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="sesLink" value="#attributes.pageToShow.getSesLink()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getSesLink()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.title>has-error</cfif>">
                            <label class="col-lg-3 control-label">Titel</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="Title" value="#attributes.pageToShow.getTitle()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getTitle()#</p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <legend>Moduleinstellungen</legend>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.moduleId>has-error</cfif>">
                            <label class="col-lg-3 control-label">Modul</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="moduleId" value="" <cfif attributes.pageToShow.getModuleId() EQ ''>checked="checked"</cfif>>
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
                                                        <input type="radio" name="moduleId" value="#installedModules[moduleIndex].id#" <cfif attributes.pageToShow.getModuleId() EQ installedModules[moduleIndex].id>checked="checked"</cfif>>
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

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.entityRegExp>has-error</cfif>">
                            <label class="col-lg-3 control-label">Entities</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="entityRegExp" value="(.*)" <cfif attributes.pageToShow.getRegExp() NEQ ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Ja">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="entityRegExp" value="" <cfif attributes.pageToShow.getRegExp() EQ ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Nein">
                                            </div>
                                        </div>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static"><cfif attributes.pageToShow.getRegExp()NEQ ''>Ja<cfelse>Nein</cfif></p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.moduleAttributes>has-error</cfif>">
                            <label class="col-lg-3 control-label">Moduloptionen</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="moduleAttributes" value="#attributes.pageToShow.getModuleAttributes()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getModuleAttributes()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.showContentForEntity>has-error</cfif>">
                            <label class="col-lg-3 control-label">Zeige bei einem Entity den Content?</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="showContentForEntity" value="true" <cfif attributes.pageToShow.showContentForEntity()>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Ja">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="showContentForEntity" value="false" <cfif NOT attributes.pageToShow.showContentForEntity()>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Nein">
                                            </div>
                                        </div>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static"><cfif attributes.pageToShow.showContentForEntity()>Ja<cfelse>Nein</cfif></p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <legend>Optionen</legend>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.description>has-error</cfif>">
                            <label class="col-lg-3 control-label">Beschreibung</label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="description" value="#attributes.pageToShow.getDescription()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getDescription()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.keywords>has-error</cfif>">
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
                                    <p class="form-control-static">#attributes.pageToShow.getVersionComment()#</p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>

                    <div class="form-group">
                        <div class="col-md-12">
                            <hr>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="pull-left">
                                <cfif NOT attributes.pageToShow.isOffline()>
                                    <cfif attributes.pageToShow.isEditable()>
                                        <button class="btn btn-sm btn-danger" type="submit" name="action" value="delete" title="Diese Version löschen"><span class="glyphicon glyphicon-trash"></span> Löschen</button>
                                    </cfif>
                                    <cfif attributes.pageToShow.isOnline()>
                                        <button class="btn btn-sm btn-warning" type="submit" name="action" value="revoke" title="Version offline nehmen"><span class="glyphicon glyphicon-off"></span> Offline nehmen</button>
								    </cfif>
								</cfif>
                            </div>
                            <div class="pull-right">
                                <cfif NOT attributes.pageToShow.isOffline()>
                                    <cfif attributes.pageToShow.isEditable()>
										<button class="btn btn-default" id="preview"><span class="glyphicon glyphicon-eye-open"></span> Vorschau</button>
                                        <button class="btn btn-default" id="edit"><span class="glyphicon glyphicon-eye-close"></span> Editieren</button>
                                        <button class="btn btn-primary" type="submit" name="action" value="save" id="save"><span class="glyphicon glyphicon-floppy-disk"></span> Speichern</button>
                                    </cfif>
                                    <cfif NOT attributes.pageToShow.isOnline()>
                                        <cfif NOT attributes.pageToShow.isReadyToRelease()>
                                            <button class="btn btn-success" type="submit" name="action" value="approve" title="In den Freigabeprozess übergeben - Nächster Status: #attributes.pageToShow.getNextStatusName()#"><span class="glyphicon glyphicon-ok"></span> Freigeben</button>
                                            <cfif NOT attributes.pageToShow.isEditable()>
                                                <button class="btn btn-sm btn-warning" type="submit" name="action" value="reject"  title="Version ablehnen - zurück zum Ersteller"><span class="glyphicon glyphicon-eye-close"></span> Ablehnen</button>
                                            </cfif>
        							    <cfelse>
                                            <button class="btn btn-success" type="submit" name="action" value="release" title="online nehmen"><span class="glyphicon glyphicon-globe"></span> Online schalten</button>
        								</cfif>
                                    </cfif>
    							</cfif>
							</div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        
        <cfinclude template="templates.cfm">

        <div class="content <cfif attributes.pageToShow.isEditable()>editable</cfif>">
            #attributes.pageToShow.getContent(themeName=request.actualUser.getTheme(), cleanArticle=true)#
        </div>
    </form>
</cfoutput>