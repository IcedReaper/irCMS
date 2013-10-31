<section class="widget" id="buddyList">
    <fieldset>
        <legend>Buddylist</legend>
        <cfif request.isLoggedIn OR attributes.userData.showBuddies()>
            <cfset buddyList = attributes.userData.getBuddylist()>
            <cfif buddyList.len() GT 0>
                <cfloop from="1" to="#arrayLen(buddyList)#" index="i">
                    <a href="/User/#buddyList[i].userName#">#buddyList[i].userName#</a>
                </cfloop>
            <cfelse>
                <div class="alert alert-info">
                    Der User hat keine Buddies.<br>
                    Helf Ihm dagegen anzukommen und stelle einen Buddyrequest!
                    <cfif request.isLoggedIn AND NOT request.actualUser.isMyBuddy(attributes.userData.getUsername())>
                        <a class="btn btn-success" href="#request.sesLink#?addBuddy">Werde mein Buddy!</a>
                    </cfif>
                </div>
            </cfif>
        <cfelse>
            <div class="alert alert-danger">Bitte loggen Sie sich ein um diesen Bereich zu sehen!</div>
        </cfif>
    </fieldset>
</section>