<cfset request.moduleClass = "userProfile">
<cfset request.pageTitle   = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.pageTitle', language=request.language)>
<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2><cf_translation keyName='modules.com.IcedReaper.irUser.registration.headline'></h2>
            </header>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12">
            <section class="widget">
                <cfif isDefined('attributes.userCreation')>
                    <cfif attributes.userCreation.success>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-success">
                                    <cf_translation keyName='modules.com.IcedReaper.irUser.registration.save.successfull.message'>
                                    <a type="button" class="btn btn-default" href="/"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.save.successfull.startpage'></a>
                                    <a type="button" class="btn btn-default" href="/User/#form.username#"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.save.successfull.profile'></a>
                                </div>
                            </div>
                        </div>
                    <cfelse>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-danger">
                                    <cfif NOT attributes.userCreation.userNameAvailable>
                                        <cf_translation keyName='modules.com.IcedReaper.irUser.registration.save.failed.userExists'>
                                    </cfif>
                                    <cf_translation keyName='modules.com.IcedReaper.irUser.registration.save.failed.message'>
                                </div>
                            </div>
                        </div>
                    </cfif>
                </cfif>
                <cfif NOT isDefined('attributes.userCreation') OR isDefined('attributes.userCreation') AND NOT attributes.userCreation.success>
                    <form id="userData" class="form-horizontal" role="form" action="#request.sesLink#" method="post">
                        <fieldset>
                            <legend><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.headline'></legend>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.username>has-error</cfif>">
                                <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.username'></label>
                                <div class="col-lg-9">
                                    <input type="text" maxLength="50" class="form-control" name="username" <cfif isDefined('attributes.userCreation')>value="#form.username#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.password>has-error</cfif>">
                                <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.password'></label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="password" <cfif isDefined('attributes.userCreation')>value="#form.password#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.passwordRetype>has-error</cfif>">
                                <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.retypePassword'></label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="passwordRetype" <cfif isDefined('attributes.userCreation')>value="#form.passwordRetype#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.email>has-error</cfif>">
                                <label class="col-lg-3 control-label" for="email"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.email'></label>
                                <div class="col-lg-9">
                                    <input type="email" maxLength="150" class="form-control" name="email" <cfif isDefined('attributes.userCreation')>value="#form.email#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.gender>has-error</cfif>">
                                <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.gender'></label>
                                <div class="col-lg-9">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="None" <cfif isDefined('attributes.userCreation') AND form.gender EQ "None" OR NOT isDefined('attributes.userCreation')>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.genderOption.none'>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Male" <cfif isDefined('attributes.userCreation') AND form.gender EQ "Male">checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.genderOption.male'>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Female" <cfif isDefined('attributes.userCreation') AND form.gender EQ "Female">checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="<cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.genderOption.female'>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="form-group">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success pull-right"><cf_translation keyName='modules.com.IcedReaper.irUser.registration.generalOptions.register'></button>
                            </div>
                        </div>
                    </form>
                </cfif>
            </section>
        </div>
    </div>
</cfoutput>