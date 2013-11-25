<cfset request.moduleClass = "userProfile">
<cfset request.pageTitle   = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.pageTitle', language=request.language)>
<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.headline', language=request.language)#</h2>
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
                                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.save.successfull.message', language=request.language)#
                                    <a type="button" class="btn btn-default" href="/">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.save.successfull.startpage', language=request.language)#</a>
                                    <a type="button" class="btn btn-default" href="/User/#form.username#">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.save.successfull.profile', language=request.language)#</a>
                                </div>
                            </div>
                        </div>
                    <cfelse>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-danger">
                                    <cfif NOT attributes.userCreation.userNameAvailable>
                                        #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.save.failed.userExists', language=request.language)#
                                    </cfif>
                                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.save.failed.message', language=request.language)#
                                </div>
                            </div>
                        </div>
                    </cfif>
                </cfif>
                <cfif NOT isDefined('attributes.userCreation') OR isDefined('attributes.userCreation') AND NOT attributes.userCreation.success>
                    <form id="userData" class="form-horizontal" role="form" action="#request.sesLink#" method="post">
                        <fieldset>
                            <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.headline', language=request.language)#</legend>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.username>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.username', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <input type="text" maxLength="50" class="form-control" name="username" <cfif isDefined('attributes.userCreation')>value="#form.username#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.password>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.password', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="password" <cfif isDefined('attributes.userCreation')>value="#form.password#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.passwordRetype>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.retypePassword', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="passwordRetype" <cfif isDefined('attributes.userCreation')>value="#form.passwordRetype#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.email>has-error</cfif>">
                                <label class="col-lg-3 control-label" for="email">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.email', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <input type="email" maxLength="150" class="form-control" name="email" <cfif isDefined('attributes.userCreation')>value="#form.email#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.gender>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.gender', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="None" <cfif isDefined('attributes.userCreation') AND form.gender EQ "None" OR NOT isDefined('attributes.userCreation')>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.genderOption.none', language=request.language)#">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Male" <cfif isDefined('attributes.userCreation') AND form.gender EQ "Male">checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.genderOption.male', language=request.language)#">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Female" <cfif isDefined('attributes.userCreation') AND form.gender EQ "Female">checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.genderOption.female', language=request.language)#">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="form-group">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success pull-right">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.registration.generalOptions.register', language=request.language)#</button>
                            </div>
                        </div>
                    </form>
                </cfif>
            </section>
        </div>
    </div>
</cfoutput>