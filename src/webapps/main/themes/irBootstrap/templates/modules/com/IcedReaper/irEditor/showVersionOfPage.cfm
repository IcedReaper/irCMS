<cfscript>
    request.pageTitle = "#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.pageTitle', language=request.language)# #attributes.pageToShow.getSesLink()#";
    application.themes.irBootstrap.cfstatic.include('/css/modules/com/IcedReaper/irEditor/');

    if(attributes.pageToShow.isEditable()) {
        application.themes.irBootstrap.cfstatic.include('/js/modules/com/IcedReaper/irEditor/')
                                               .include('/js/vendor/jquery_plugins/jquery.sortable.js');

        var jsTranslation = {};
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.Interval']        = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.Interval', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.pause']           = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.pause', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.wrap']            = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.wrap', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.path']        = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.path', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.title']       = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.title', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.headline']    = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.headline', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.description'] = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.description', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.path']           = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.path', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.description']    = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.description', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.height']         = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.height', language=request.language);
        jsTranslation['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.marginTop']      = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.marginTop', language=request.language);

        application.themes.irBootstrap.cfstatic.includeData(jsTranslation);
        
        application.tools.wrapper.htmlHead('<script src="/themes/irBootstrap/js/vendor/tinyMce/jquery.tinymce.min.js" charset="utf-8"></script>');
        application.tools.wrapper.htmlHead('<script src="/themes/irBootstrap/js/vendor/tinyMce/tinymce.min.js" charset="utf-8"></script>');
    }
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
                    <h2>#attributes.pageToShow.getLinkname()#<small><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.version'>: #attributes.version#</small></h2>
                </header>
            </div>
        </div>

        <div class="row" id="pageOptions">
            <div class="col-md-12">
                <section class="widget">
                    <cfif isDefined('attributes.contentUpdate')>
                        <cfif attributes.contentUpdate.success>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-success">
                                        <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.saveSuccessfull'>
                                    </div>
                                </div>
                            </div>
                        <cfelse>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-danger">
                                        <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.saveFailed'>
                                    </div>
                                </div>
                            </div>
                        </cfif>
                    </cfif>
                    <fieldset>
                        <legend><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.mandatory'></legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.actualStatus'></label>
                            <div class="col-lg-9">
                                <p class="form-control-static">#attributes.pageToShow.getStatusName()#</p>
                            </div>
                        </div>
                        
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.linkName>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.linkname'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="Linkname" value="#attributes.pageToShow.getLinkname()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getLinkname()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.sesLink>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.sesLink'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="sesLink" value="#attributes.pageToShow.getSesLink()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getSesLink()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.title>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.title'></label>
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
                        <legend><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.moduleSettings'></legend>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.moduleId>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.module'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="moduleId" value="" <cfif attributes.pageToShow.getModuleId() EQ ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.noModule'>">
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
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.entities'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="entityRegExp" value="(.*)" <cfif attributes.pageToShow.getRegExp() NEQ ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.yes'>">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="entityRegExp" value="" <cfif attributes.pageToShow.getRegExp() EQ ''>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.no'>">
                                            </div>
                                        </div>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static"><cfif attributes.pageToShow.getRegExp() NEQ ''><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.yes'><cfelse><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.no'></cfif></p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.moduleAttributes>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.moduleOptions'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="moduleAttributes" value="#attributes.pageToShow.getModuleAttributes()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getModuleAttributes()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.showContentForEntity>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.showContentForEntity'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="showContentForEntity" value="true" <cfif attributes.pageToShow.showContentForEntity()>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.yes'>">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="showContentForEntity" value="false" <cfif NOT attributes.pageToShow.showContentForEntity()>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.no'>">
                                            </div>
                                        </div>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static"><cfif attributes.pageToShow.showContentForEntity()><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.yes'><cfelse><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.no'></cfif></p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset>
                        <legend><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.options'></legend>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.description>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.description'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="description" value="#attributes.pageToShow.getDescription()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getDescription()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.keywords>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.keywords'></label>
                            <div class="col-lg-9">
                                <cfif attributes.pageToShow.isEditable()>
                                    <input type="text" maxLength="150" class="form-control" name="keywords" value="#attributes.pageToShow.getKeywords()#">
                                <cfelse>
                                    <p class="form-control-static">#attributes.pageToShow.getKeywords()#</p>
                                </cfif>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.versionComment'></label>
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
                </section>
            </div>
        </div>
        <div class="row" id="actionBar">
            <div class="col-md-12">
                <section class="widget">
                    <div class="form-group">
                        <div class="col-md-12">
                            <div class="pull-left">
                                <cfif NOT attributes.pageToShow.isOffline()>
                                    <cfif attributes.pageToShow.isEditable()>
                                        <button class="btn btn-sm btn-danger" type="submit" name="action" value="delete" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.buttonTitle.delete'>"><span class="glyphicon glyphicon-trash"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.delete'></button>
                                    </cfif>
                                    <cfif attributes.pageToShow.isOnline()>
                                        <button class="btn btn-sm btn-warning" type="submit" name="action" value="revoke" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.buttonTitle.revoke'>"><span class="glyphicon glyphicon-off"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.revoke'></button>
								    </cfif>
								</cfif>
                            </div>
                            <div class="pull-right">
                                <cfif NOT attributes.pageToShow.isOffline()>
                                    <cfif attributes.pageToShow.isEditable()>
                                        <button class="btn btn-default" id="sort"><span class="glyphicon glyphicon-sort"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.enableSort'></button>
                                        <button class="btn btn-default" id="fix"><span class="glyphicon glyphicon-pushpin"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.disableSort'></button>
                                        
                                        <button class="btn btn-default" id="preview"><span class="glyphicon glyphicon-eye-open"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.preview'></button>
                                        <button class="btn btn-default" id="edit"><span class="glyphicon glyphicon-eye-close"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.edit'></button>
                                        
                                        <button class="btn btn-primary" type="submit" name="action" value="save" id="save"><span class="glyphicon glyphicon-floppy-disk"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.save'></button>
                                    </cfif>
                                    <cfif NOT attributes.pageToShow.isOnline()>
                                        <cfif NOT attributes.pageToShow.isReadyToRelease()>
                                            <button class="btn btn-success" type="submit" name="action" value="approve" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.buttonTitle.approve'> #attributes.pageToShow.getNextStatusName()#"><span class="glyphicon glyphicon-ok"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.approve'></button>
                                            <cfif NOT attributes.pageToShow.isEditable()>
                                                <button class="btn btn-sm btn-warning" type="submit" name="action" value="reject"  title="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.buttonTitle.reject'>"><span class="glyphicon glyphicon-eye-close"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.reject'></button>
                                            </cfif>
        							    <cfelse>
                                            <button class="btn btn-success" type="submit" name="action" value="release" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.buttonTitle.release'>"><span class="glyphicon glyphicon-globe"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageEdit.button.release'></button>
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