<cfset request.moduleClass = "userProfile">
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    #attributes.moduleData.userData.getUsername()#
                    <small>#attributes.moduleData.userData.getTitle()#</small>
                </h2>
            </header>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <section class="widget" id="avatar">
                <img src="#attributes.moduleData.userData.getAvatar()#" alt="#attributes.moduleData.userData.getUsername()# Avatar">
            </section>
        </div>
        <div class="col-md-6">
            <section class="widget" id="userData">
                <fieldset>
                    <legend>Allgemeine Infos</legend>
                    <div>
                        <label>Dabei seit</label>
                        <div>
                            <input readonly value="#attributes.moduleData.userData.getJoinDate()#">
                        </div>
                    </div>
                    <div>
                        <label>Geschlecht</label>
                        <div>
                            <cfif NOT attributes.moduleData.isMyUser>
                                <input readonly value="#attributes.moduleData.userData.getGender()#">
                            <cfelse>
                            </cfif>
                        </div>
                    </div>
                    <cfif request.isLoggedIn || attributes.moduleData.userData.isEmailPublic()>
                        <div>
                            <label>Email</label>
                            <div>
                                <input <cfif NOT attributes.moduleData.isMyUser>readonly</cfif> value="#attributes.moduleData.userData.getEmail()#" name="email">
                                <cfif NOT attributes.moduleData.isMyUser>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-success">Write an email</button>
                                    </span>
                                </cfif>
                            </div>
                        </div>
                    </cfif>
                    <div>
                        <label>Hobbies</label>
                        <div>
                            <textarea <cfif NOT attributes.moduleData.isMyUser>readonly</cfif> name="hobbies">#attributes.moduleData.userData.getHobbies()#</textarea>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Social Media Info</legend>
                    <div>
                        <label>Homepage</label>
                        <div>
                            <input <cfif NOT attributes.moduleData.isMyUser>readonly</cfif> value="#attributes.moduleData.userData.getHomepage()#" name="homepage">
                        </div>
                    </div>
                    <div>
                        <label>Facebook</label>
                        <div>
                            <input <cfif NOT attributes.moduleData.isMyUser>readonly</cfif> value="#attributes.moduleData.userData.getFacebookLink()#" name="facebook">
                        </div>
                    </div>
                    <div>
                        <label>Twitter</label>
                        <div>
                            <input <cfif NOT attributes.moduleData.isMyUser>readonly</cfif> value="#attributes.moduleData.userData.getTwitterLink()#" name="twitter">
                        </div>
                    </div>
                    <div>
                        <label>Github</label>
                        <div>
                            <input <cfif NOT attributes.moduleData.isMyUser>readonly</cfif> value="#attributes.moduleData.userData.getGithubLink()#" name="github">
                        </div>
                    </div>
                </fieldset>
            </section>
        </div>
        <div class="col-md-4">
            <div class="row">
                <div class="col-md-12">
                    <section class="widget" id="userFeed">
                        <header>User feed</header>
                    </section>
                </div>
                <div class="col-md-12">
                    <section class="widget" id="buddyList">
                        <header>Buddy List</header>
                        <cfif request.isLoggedIn OR attributes.moduleData.userData.showBuddies()>
                            <cfset buddyList = attributes.moduleData.userData.getBuddylist()>
                            <cfif buddyList.len() EQ 0>
                                <div class="alert alert-info">
                                    Der User hat keine Buddies.<br>
                                    Helf Ihm dagegen anzukommen und stelle einen Buddyrequest!
                                    <cfif request.isLoggedIn>
                                        <button type="button" class="btn btn-success">Werde mein Buddy!</button>
                                    </cfif>
                                </div>
                            <cfelse>
                                <cfloop from="1" to="#arrayLen(buddyList)#" index="i">
                                    <a href="/User/#buddyList[i].userName#">#buddyList[i].userName#</a>
                                </cfloop>
                            </cfif>
                        <cfelse>
                            <div class="alert alert-danger">Bitte loggen Sie sich ein um diesen Bereich zu sehen!</div>
                        </cfif>
                    </section>
                </div>
            </div>
        </div>
    </div>
</cfoutput>