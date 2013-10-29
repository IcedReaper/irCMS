<cfset request.moduleClass = "userProfile">
<cfset request.pageTitle   = "Profilseite von #attributes.moduleData.userData.getUsername()#">
<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    #attributes.moduleData.userData.getUsername()#
                    <small>#attributes.moduleData.userData.getTitle()#</small>
                </h2>
            </header>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-2">
            <section class="widget" id="avatar">
                <img src="#attributes.moduleData.userData.getAvatar()#" alt="#attributes.moduleData.userData.getUsername()# Avatar">
            </section>
        </div>
        <div class="col-md-6">
            <section class="widget">
                <form id="userData" class="form-horizontal" role="form" <cfif attributes.moduleData.isMyUser>action="#request.sesLink#" method="post"</cfif>
                    <fieldset>
                        <legend>Allgemeine Infos</legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Dabei seit</label>
                            <div class="col-lg-9">
                                <p class="form-control-static">#DateFormat(attributes.moduleData.userData.getJoinDate(), "DD. MMM YYYY")# #TimeFormat(attributes.moduleData.userData.getJoinDate(), "HH:MM")#</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Geschlecht</label>
                            <div class="col-lg-9">
                                <cfif attributes.moduleData.isMyUser>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="None">
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Keine Angabe">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Male">
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Männlich">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" name="gender" value="Female">
                                                </span>
                                                <input type="text" class="form-control" disabled="disabled" value="Weiblich">
                                            </div>
                                        </div>
                                    </div>
                                <cfelse>
                                    <p class="form-control-static">#attributes.moduleData.userData.getGender()#</p>
                                </cfif>
                            </div>
                        </div>
                        <cfif request.isLoggedIn || attributes.moduleData.userData.isEmailPublic()>
                            <div class="form-group">
                                <label class="col-lg-3 control-label" for="email">Email</label>
                                <div class="col-lg-9">
                                    <cfif attributes.moduleData.isMyUser>
                                        <input type="email" maxLength="150" class="form-control" name="email" value="#attributes.moduleData.userData.getEmail()#">
                                    <cfelse>
                                        <p class="form-control-static">#application.tools.tools.encryptEmail(attributes.moduleData.userData.getEmail())#</p>
                                        <!--- TODO: add user Option if email sending is activated or not --->
                                        <cfif attributes.moduleData.userData.getEmail() NEQ "">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-success">Write an email</button>
                                            </span>
                                        </cfif>
                                    </cfif>
                                </div>
                            </div>
                        </cfif>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="hobbies">Hobbies</label>
                            <div class="col-lg-9">
                                <cfif attributes.moduleData.isMyUser>
                                    <textarea maxLength="250" class="form-control" name="hobbies">#attributes.moduleData.userData.getHobbies()#</textarea>
                                <cfelse>
                                    <p class="form-control-static">#attributes.moduleData.userData.getHobbies()#</p>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <legend>Social Media Info</legend>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="homepage">Homepage</label>
                            <div class="col-lg-9">
                                <cfif attributes.moduleData.isMyUser>
                                    <input type="text" maxLength="255"  class="form-control" name="homepage" value="#attributes.moduleData.userData.getHomepage()#">
                                <cfelse>
                                    <cfif attributes.moduleData.userData.getHomepage() NEQ "">
                                        <p class="form-control-static"><a href="http://#attributes.moduleData.userData.getHomepage()#">#attributes.moduleData.userData.getHomepage()# <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="facebook">Facebook</label>
                            <div class="col-lg-9">
                                <cfif attributes.moduleData.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="facebook" value="#attributes.moduleData.userData.getFacebookLink()#">
                                <cfelse>
                                    <cfif attributes.moduleData.userData.getFacebookLink() NEQ "">
                                        <p class="form-control-static"><a href="https://www.facebook.com/#attributes.moduleData.userData.getFacebookLink()#">#attributes.moduleData.userData.getUsername()# auf Facebook <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Twitter</label>
                            <div class="col-lg-9">
                                <cfif attributes.moduleData.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="twitter" value="#attributes.moduleData.userData.getTwitterLink()#">
                                <cfelse>
                                    <cfif attributes.moduleData.userData.getTwitterLink() NEQ "">
                                        <p class="form-control-static"><a href="https://www.twitter/#attributes.moduleData.userData.getTwitterLink()#">#attributes.moduleData.userData.getUsername()# auf Twitter <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Github</label>
                            <div class="col-lg-9">
                                <cfif attributes.moduleData.isMyUser>
                                    <input type="text" maxLength="50" class="form-control" name="github" value="#attributes.moduleData.userData.getGithubLink()#">
                                <cfelse>
                                    <cfif attributes.moduleData.userData.getGithubLink() NEQ "">
                                        <p class="form-control-static"><a href="http://www.github.com/#attributes.moduleData.userData.getGithubLink()#">#attributes.moduleData.userData.getUsername()# auf Github <i class="glyphicon glyphicon-link"></i></a></p>
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                    </fieldset>
                    <cfif attributes.moduleData.isMyUser>
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
                    <section class="widget" id="buddyList">
                        <fieldset>
                            <legend>Buddylist</legend>
                            <cfif request.isLoggedIn OR attributes.moduleData.userData.showBuddies()>
                                <cfset buddyList = attributes.moduleData.userData.getBuddylist()>
                                <cfif buddyList.len() GT 0>
                                    <cfloop from="1" to="#arrayLen(buddyList)#" index="i">
                                        <a href="/User/#buddyList[i].userName#">#buddyList[i].userName#</a>
                                    </cfloop>
                                <cfelse>
                                    <div class="alert alert-info">
                                        Der User hat keine Buddies.<br>
                                        Helf Ihm dagegen anzukommen und stelle einen Buddyrequest!
                                        <cfif request.isLoggedIn AND 
                                              NOT request.actualUser.isMyBuddy(attributes.moduleData.userData.getUsername())>
                                            <a class="btn btn-success" href="#request.sesLink#?addBuddy">Werde mein Buddy!</a>
                                        </cfif>
                                    </div>
                                </cfif>
                            <cfelse>
                                <div class="alert alert-danger">Bitte loggen Sie sich ein um diesen Bereich zu sehen!</div>
                            </cfif>
                        </fieldset>
                    </section>
                </div>
            </div>
        </div>
    </div>
</cfoutput>