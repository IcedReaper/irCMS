<cfset request.moduleClass = "userProfile">
<cfset request.pageTitle   = "#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.pageTitle', language=request.language)# #attributes.userData.getUsername()#">
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
                                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.update.successfull', language=request.language)#
                                </div>
                            </div>
                        </div>
                    <cfelse>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-danger">
                                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.update.failed', language=request.language)#
                                </div>
                            </div>
                        </div>
                    </cfif>
                </cfif>
                <form id="userData" class="form-horizontal" role="form" <cfif attributes.isMyUser>action="#request.sesLink#" method="post"</cfif>>
                    <fieldset>
                        <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.headline', language=request.language)#</legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.activeSince', language=request.language)#</label>
                            <div class="col-lg-9">
                                <p class="form-control-static">#DateFormat(attributes.userData.getJoinDate(), "DD. MMM YYYY")# #TimeFormat(attributes.userData.getJoinDate(), "HH:MM")#</p>
                            </div>
                        </div>
                        <cfif attributes.isMyUser>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.title>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.title', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <input type="text" maxLength="50" class="form-control" name="title" value="#attributes.userData.getTitle()#">
                                </div>
                            </div>
                        </cfif>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.gender>has-error</cfif>">
                            <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.gender', language=request.language)#</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
								    <div class="btn-group" data-toggle="buttons" id="genderSelection">
                                        <label class="btn btn-default <cfif attributes.userData.getGender() EQ 'Male'>active</cfif>">
                                            <input type="radio" name="gender" id="Male" value="Male" <cfif attributes.userData.getGender() EQ 'Male'>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.genderOption.male', language=request.language)#
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.getGender() EQ 'Female'>active</cfif>">
                                            <input type="radio" name="gender" id="Female" value="Female" <cfif attributes.userData.getGender() EQ 'Female'>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.genderOption.female', language=request.language)#
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.getGender() EQ 'None'>active</cfif>">
                                            <input type="radio" name="gender" id="None" value="None" <cfif attributes.userData.getGender() EQ 'None'>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.genderOption.none', language=request.language)#
                                        </label>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.genderOption.'&attributes.userData.getGender(), language=request.language)#</p>
                                </cfif>
                            </div>
                        </div>
                        <cfif request.isLoggedIn || attributes.userData.isEmailPublic()>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.email>has-error</cfif>">
                                <label class="col-lg-3 control-label" for="email">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.email', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <cfif attributes.isMyUser>
                                        <input type="email" maxLength="150" class="form-control" name="email" value="#attributes.userData.getEmail()#">
                                    <cfelse>
                                        <p class="form-control-static">#application.tools.tools.encryptEmail(attributes.userData.getEmail())#</p>
                                        <!--- TODO: add user Option if email sending is activated or not --->
                                        <cfif attributes.userData.getEmail() NEQ "">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-success">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.sendEmail', language=request.language)#</button>
                                            </span>
                                        </cfif>
                                    </cfif>
                                </div>
                            </div>
                        </cfif>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.hobbies>has-error</cfif>">
                            <label class="col-lg-3 control-label" for="hobbies">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.hobbies', language=request.language)#</label>
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
                            <label class="col-lg-3 control-label" for="homepage">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.homepage', language=request.language)#</label>
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
                            <label class="col-lg-3 control-label" for="facebook">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.facebook', language=request.language)#</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="facebook" value="#attributes.userData.getFacebookLink()#">
                                <cfelse>
                                    <cfif attributes.userData.getFacebookLink() NEQ "">
                                        <p class="form-control-static"><a href="https://www.facebook.com/#attributes.userData.getFacebookLink()#">#attributes.userData.getUsername()# #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.on.facebook', language=request.language)# <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.twitter>has-error</cfif>">
                            <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.twitter', language=request.language)#</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="twitter" value="#attributes.userData.getTwitterLink()#">
                                <cfelse>
                                    <cfif attributes.userData.getTwitterLink() NEQ "">
                                        <p class="form-control-static"><a href="https://www.twitter/#attributes.userData.getTwitterLink()#">#attributes.userData.getUsername()# #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.on.twitter', language=request.language)# <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.github>has-error</cfif>">
                            <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.github', language=request.language)#</label>
                            <div class="col-lg-9">
                                <cfif attributes.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="github" value="#attributes.userData.getGithubLink()#">
                                <cfelse>
                                    <cfif attributes.userData.getGithubLink() NEQ "">
                                        <p class="form-control-static"><a href="http://www.github.com/#attributes.userData.getGithubLink()#">#attributes.userData.getUsername()# #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.generalOptions.on.github', language=request.language)# <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>
                    <cfif attributes.isMyUser>
                        <fieldset>
                            <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.headline', language=request.language)#</legend>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.emailPublic>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.showEmail', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <div class="btn-group" data-toggle="buttons" id="genderSelection">
                                        <label class="btn btn-default <cfif NOT attributes.userData.isEmailPublic()>active</cfif>">
                                            <input type="radio" name="emailPublic" id="False" value="false" <cfif NOT attributes.userData.isEmailPublic()>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.no', language=request.language)#
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.isEmailPublic()>active</cfif>">
                                            <input type="radio" name="emailPublic" id="True" value="True" <cfif attributes.userData.isEmailPublic()>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.yes', language=request.language)#
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.themeId>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.theme', language=request.language)#</label>
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
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.password', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <input type="password" maxLength="50" class="form-control" name="password">
                                </div>
                            </div>
                            <!--- has to be moved to the irUserBuddy module --->
                            <div class="form-group <cfif isDefined('attributes.userUpdate') AND NOT attributes.userUpdate.showBuddies>has-error</cfif>">
                                <label class="col-lg-3 control-label">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.showBuddies', language=request.language)#</label>
                                <div class="col-lg-9">
                                    <div class="btn-group" data-toggle="buttons" id="genderSelection">
                                        <label class="btn btn-default <cfif NOT attributes.userData.showBuddies()>active</cfif>">
                                            <input type="radio" name="showBuddies" id="False" value="false" <cfif NOT attributes.userData.showBuddies()>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings', language=request.language)#
                                        </label>
                                        <label class="btn btn-default <cfif attributes.userData.showBuddies()>active</cfif>">
                                            <input type="radio" name="showBuddies" id="True" value="True" <cfif attributes.userData.showBuddies()>checked="checked"</cfif>> #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings', language=request.language)#
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <div class="form-group">
                            <div class="col-md-12">
                                <button type="submit" class="btn btn-success pull-right">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.profileSettings.save', language=request.language)#</button>
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
                            <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.profile.lastActivities', language=request.language)#</legend>
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