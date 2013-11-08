<cfset request.moduleClass = "userProfile">
<cfset request.pageTitle   = "Profilseite von #attributes.userData.getUsername()#">
<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    #attributes.userData.getUsername()#
                    <small>#attributes.userData.getTitle()#</small>
                </h2>
            </header>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-2">
            <section class="widget" id="avatar">
                <img src="#attributes.userData.getAvatar()#" alt="#attributes.userData.getUsername()# Avatar">
            </section>
        </div>
        <div class="col-md-6">
            <section class="widget">
                <cfif isDefined('attributes.userUpdate')>
                    <cfif attributes.userUpdate.success>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-success">
                                    Ihr Profil wurde erfolgreich aktualisiert.
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
                <form id="userData" class="form-horizontal" role="form" <cfif attributes.isMyUser>action="#request.sesLink#" method="post"</cfif>>
                    <fieldset>
                        <legend>Allgemeine Infos</legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Dabei seit</label>
                            <div class="col-lg-9">
                                <p class="form-control-static">#DateFormat(attributes.userData.getJoinDate(), "DD. MMM YYYY")# #TimeFormat(attributes.userData.getJoinDate(), "HH:MM")#</p>
                            </div>
                        </div>
                        <cfif attributes.isMyUser>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.title>has-error</cfif>">
                                <label class="col-lg-3 control-label">Titel</label>
                                <div class="col-lg-9">
                                    <input type="text" maxLength="50" class="form-control" name="title" value="#attributes.userData.getTitle()#">
                                </div>
                            </div>
                        </cfif>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.gender>has-error</cfif>">
                            <label class="col-lg-3 control-label">Geschlecht</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
								    <div class="btn-group" data-toggle="buttons" id="genderSelection">
                                        <label class="btn btn-default <cfif attributes.userData.getGender() EQ 'Male'>active</cfif>">
                                            <input type="radio" name="gender" id="Male" value="Male" <cfif attributes.userData.getGender() EQ 'Male'>checked="checked"</cfif>> Männlich
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.getGender() EQ 'Female'>active</cfif>">
                                            <input type="radio" name="gender" id="Female" value="Female" <cfif attributes.userData.getGender() EQ 'Female'>checked="checked"</cfif>> Weiblich
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.getGender() EQ 'None'>active</cfif>">
                                            <input type="radio" name="gender" id="None" value="None" <cfif attributes.userData.getGender() EQ 'None'>checked="checked"</cfif>> Keine Angabe
                                        </label>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static">#attributes.userData.getGender()#</p>
                                </cfif>
                            </div>
                        </div>
                        <cfif request.isLoggedIn || attributes.userData.isEmailPublic()>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.email>has-error</cfif>">
                                <label class="col-lg-3 control-label" for="email">Email</label>
                                <div class="col-lg-9">
                                    <cfif attributes.isMyUser>
                                        <input type="email" maxLength="150" class="form-control" name="email" value="#attributes.userData.getEmail()#">
                                    <cfelse>
                                        <p class="form-control-static">#application.tools.tools.encryptEmail(attributes.userData.getEmail())#</p>
                                        <!--- TODO: add user Option if email sending is activated or not --->
                                        <cfif attributes.userData.getEmail() NEQ "">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-success">Write an email</button>
                                            </span>
                                        </cfif>
                                    </cfif>
                                </div>
                            </div>
                        </cfif>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.hobbies>has-error</cfif>">
                            <label class="col-lg-3 control-label" for="hobbies">Hobbies</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <textarea maxLength="250" class="form-control" name="hobbies">#attributes.userData.getHobbies()#</textarea>
                                <cfelse>
                                    <p class="form-control-static">#attributes.userData.getHobbies()#</p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>Social Media Info</legend>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.homepage>has-error</cfif>">
                            <label class="col-lg-3 control-label" for="homepage">Homepage</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="255"  class="form-control" name="homepage" value="#attributes.userData.getHomepage()#">
                                <cfelse>
                                    <cfif attributes.userData.getHomepage() NEQ "">
                                        <p class="form-control-static"><a href="http://#attributes.userData.getHomepage()#">#attributes.userData.getHomepage()# <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.facebook>has-error</cfif>">
                            <label class="col-lg-3 control-label" for="facebook">Facebook</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="facebook" value="#attributes.userData.getFacebookLink()#">
                                <cfelse>
                                    <cfif attributes.userData.getFacebookLink() NEQ "">
                                        <p class="form-control-static"><a href="https://www.facebook.com/#attributes.userData.getFacebookLink()#">#attributes.userData.getUsername()# auf Facebook <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.twitter>has-error</cfif>">
                            <label class="col-lg-3 control-label">Twitter</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="twitter" value="#attributes.userData.getTwitterLink()#">
                                <cfelse>
                                    <cfif attributes.userData.getTwitterLink() NEQ "">
                                        <p class="form-control-static"><a href="https://www.twitter/#attributes.userData.getTwitterLink()#">#attributes.userData.getUsername()# auf Twitter <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.github>has-error</cfif>">
                            <label class="col-lg-3 control-label">Github</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="github" value="#attributes.userData.getGithubLink()#">
                                <cfelse>
                                    <cfif attributes.userData.getGithubLink() NEQ "">
                                        <p class="form-control-static"><a href="http://www.github.com/#attributes.userData.getGithubLink()#">#attributes.userData.getUsername()# auf Github <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>
                    <cfif attributes.isMyUser>
                        <fieldset>
                            <legend>Profileinstellungen</legend>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.emailPublic>has-error</cfif>">
                                <label class="col-lg-3 control-label">Email anzeigen?</label>
                                <div class="col-lg-9">
                                    <div class="btn-group" data-toggle="buttons" id="genderSelection">
                                        <label class="btn btn-default <cfif NOT attributes.userData.isEmailPublic()>active</cfif>">
                                            <input type="radio" name="emailPublic" id="False" value="false" <cfif NOT attributes.userData.isEmailPublic()>checked="checked"</cfif>> Nein
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.isEmailPublic()>active</cfif>">
                                            <input type="radio" name="emailPublic" id="True" value="True" <cfif attributes.userData.isEmailPublic()>checked="checked"</cfif>> Ja
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.themeId>has-error</cfif>">
                                <label class="col-lg-3 control-label">Theme</label>
                                <div class="col-lg-9">
                                    <cfset qThemes = application.cms.core.getThemes()>
                                    <cfloop query="qThemes">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <input type="radio" name="themeId" value="#qThemes.themeId#" <cfif attributes.userData.getThemeId() EQ qThemes.themeId>checked="checked"</cfif>>
                                                    </span>
                                                    <input type="text" class="form-control" disabled="disabled" value="#qThemes.themeName#">
                                                </div>
                                            </div>
                                        </div>
                                    </cfloop>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.password>has-error</cfif>">
                                <label class="col-lg-3 control-label">Passwort</label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="password">
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.showBuddies>has-error</cfif>">
                                <label class="col-lg-3 control-label">Buddies anzeigen?</label>
                                <div class="col-lg-9">
                                    <div class="btn-group" data-toggle="buttons" id="genderSelection">
                                        <label class="btn btn-default <cfif NOT attributes.userData.showBuddies()>active</cfif>">
                                            <input type="radio" name="showBuddies" id="False" value="false" <cfif NOT attributes.userData.showBuddies()>checked="checked"</cfif>> Nein
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.showBuddies()>active</cfif>">
                                            <input type="radio" name="showBuddies" id="True" value="True" <cfif attributes.userData.showBuddies()>checked="checked"</cfif>> Ja
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="form-group">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success pull-right">Speichern</button>
                            </div>
                        </div>
                    </cfif>
                </form>
            </section>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <section class="widget" id="userFeed">
                        <fieldset>
                            <legend>Last Activities</legend>
                        </fieldset>
                    </section>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <cfset buddyModule = application.cms.core.getModulePath('Buddies')>
					<cfif buddyModule NEQ "">
						<cfmodule template="/system/modules/#buddyModule#/index.cfm" userName="#attributes.userData.getUsername()#">
					</cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>