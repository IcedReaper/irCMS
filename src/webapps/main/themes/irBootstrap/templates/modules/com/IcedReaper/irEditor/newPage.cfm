<cfscript>
    request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.pageNew.pageTitle', language=request.language);
    application.themes.irBootstrap.cfstatic.include('/css/modules/com/IcedReaper/irEditor/')
                                           .include('/js/modules/com/IcedReaper/irEditor/newPage.js');
</cfscript>
<cfoutput>
    <form action="#request.sesLink#" method="post" class="form-horizontal" role="form" id="irEditor">
        <input type="hidden" name="content">
        <div class="row">
            <div class="col-md-12">
                <cfmodule template="navigation.cfm" navigationId="0">
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <header class="widget">
                    <h2><cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.headline'></h2>
                </header>
            </div>
        </div>

        <div class="row" id="pageOptions">
            <div class="col-md-12">
                <section class="widget">
                    <cfif isDefined('attributes.contentUpdate')>
                        <cfif NOT attributes.contentUpdate.success>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="alert alert-danger">
                                        <cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.saveFailed'>
                                    </div>
                                </div>
                            </div>
                        </cfif>
                    </cfif>
                    <fieldset class="toggleable">
                        <legend>Optionen</legend>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.language>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.language'></label>
                            <div class="col-lg-9">
                                <select name="language">
                                    <option value="de"><cf_translation keyName='core.languages.german'></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.position>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.navigation'></label>
                            <div class="col-lg-9">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="position" value="header" checked="checked">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="header">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="position" value="footer">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="footer">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="position" value="admin">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="admin">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="position" value="hidden">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="hidden">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group" id="newPosition">
                                            <span class="input-group-addon">
                                                <input type="radio" name="position" value="">
                                            </span>
                                            <input type="text" class="form-control col-md-6" value="" name="newPosition" placeholder="Neue Position">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.contentUpdate') AND NOT attributes.contentUpdate.navigationToShow>has-error</cfif>">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.showNavigation'></label>
                            <div class="col-lg-9">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="navigationToShow" value="header" checked="checked">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="header">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="navigationToShow" value="admin">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="admin">
                                        </div>
                                    </div>
                                </div>
                                <div class="row" id="newPositionToShow">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" name="navigationToShow" value="">
                                            </span>
                                            <input type="text" class="form-control" disabled="disabled" value="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <div class="pull-left">
                                    <a class="btn btn-sm btn-danger" href="#attributes.sesLink#"><span class="glyphicon glyphicon-ban-circle"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.cancel'></a>
                                </div>
                                <div class="pull-right">
                                    <button class="btn btn-success" type="submit"><span class="glyphicon glyphicon-save"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.pageNew.save'></button>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </section>
            </div>
        </div>
    </form>
</cfoutput>