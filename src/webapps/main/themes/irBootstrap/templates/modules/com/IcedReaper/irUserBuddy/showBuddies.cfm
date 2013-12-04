<cfoutput>
	<section class="widget" id="buddyList">
	    <fieldset>
	        <legend><cf_translation keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.headline'></legend>
	        <cfif request.isLoggedIn OR attributes.userData.showBuddies()>
	            <cfset buddyList = attributes.userData.getBuddylist()>
	            <cfif buddyList.len() GT 0>
	                <cfloop from="1" to="#arrayLen(buddyList)#" index="i">
	                    <a href="/User/#buddyList[i].userName#">#buddyList[i].userName#</a>
	                </cfloop>
	            <cfelse>
	                <div class="alert alert-info">
	                    <cf_translation keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.message'>
	                    <cfif request.isLoggedIn AND NOT request.actualUser.isMyBuddy(attributes.userData.getUsername())>
	                        <a class="btn btn-success" href="#request.sesLink#?addBuddy"><cf_translation keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.addBuddy'></a>
	                    </cfif>
	                </div>
	            </cfif>
	        <cfelse>
	            <div class="alert alert-danger"><cf_translation keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.pleaseLogin'></div>
	        </cfif>
	    </fieldset>
	</section>
</cfoutput>