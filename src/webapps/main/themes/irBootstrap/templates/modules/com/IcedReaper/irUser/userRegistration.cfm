<cfset request.moduleClass = "userProfile">
<cfset request.pageTitle   = "Registrierung">
<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2>Registrierung</h2>
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
                                    Ihr Profil wurde erfolgreich erstellt.<br>
                                    Gehen Sie hier auf Ihr Profil oder auf die Startseite.<br>
                                    <a type="button" class="btn btn-default" href="/">Zur Startseite</a>
                                    <a type="button" class="btn btn-default" href="/User/#form.username#">Ihr Profil</a>
                                </div>
                            </div>
                        </div>
                    <cfelse>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-danger">
                                    <cfif NOT attributes.userCreation.userNameAvailable>
                                        Der Username ist bereits vorhanden. Bitte wählen Sie einen anderen.<br>
                                    </cfif>
                                    Während des Speicherns konnte ein oder mehrere Felder nicht korrekt validiert werden.<br>
                                    Bitte gucken Sie sich unten die rot markierten Felder an und korrigieren Sie diese.
                                </div>
                            </div>
                        </div>
                    </cfif>
                </cfif>
                <cfif NOT isDefined('attributes.userCreation') OR isDefined('attributes.userCreation') AND NOT attributes.userCreation.success>
                    <form id="userData" class="form-horizontal" role="form" action="#request.sesLink#" method="post">
                        <fieldset>
                            <legend>Allgemeine Infos</legend>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.username>has-error</cfif>">
                                <label class="col-lg-3 control-label">Username</label>
                                <div class="col-lg-9">
                                    <input type="text" maxLength="50" class="form-control" name="username" <cfif isDefined('attributes.userCreation')>value="#form.username#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.password>has-error</cfif>">
                                <label class="col-lg-3 control-label">Passwort</label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="password" <cfif isDefined('attributes.userCreation')>value="#form.password#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.passwordRetype>has-error</cfif>">
                                <label class="col-lg-3 control-label">Passwort wiederholen</label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="passwordRetype" <cfif isDefined('attributes.userCreation')>value="#form.passwordRetype#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.email>has-error</cfif>">
                                <label class="col-lg-3 control-label" for="email">Email</label>
                                <div class="col-lg-9">
                                    <input type="email" maxLength="150" class="form-control" name="email" <cfif isDefined('attributes.userCreation')>value="#form.email#"</cfif>>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userCreation') AND NOT attributes.userCreation.gender>has-error</cfif>">
                                <label class="col-lg-3 control-label">Geschlecht</label>
                                <div class="col-lg-9">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="None" <cfif isDefined('attributes.userCreation') AND form.gender EQ "None" OR NOT isDefined('attributes.userCreation')>checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Keine Angabe">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Male" <cfif isDefined('attributes.userCreation') AND form.gender EQ "Male">checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Männlich">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Female" <cfif isDefined('attributes.userCreation') AND form.gender EQ "Female">checked="checked"</cfif>>
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Weiblich">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="form-group">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success pull-right">Registrieren</button>
                            </div>
                        </div>
                    </form>
                </cfif>
            </section>
        </div>
    </div>
</cfoutput>