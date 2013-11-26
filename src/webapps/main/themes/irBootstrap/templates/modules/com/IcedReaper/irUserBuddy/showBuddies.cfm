<cfoutput>
	<section class="widget" id="buddyList">
	    <fieldset>
	        <legend>#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.headline', language=request.language)#</legend>
	        <cfif request.isLoggedIn OR attributes.userData.showBuddies()>
	            <cfset buddyList = attributes.userData.getBuddylist()>
	            <cfif buddyList.len() GT 0>
	                <cfloop from="1" to="#arrayLen(buddyList)#" index="i">
	                    <a href="/User/#buddyList[i].userName#">#buddyList[i].userName#</a>
	                </cfloop>
	            <cfelse>
	                <div class="alert alert-info">
	                    #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.message', language=request.language)#
	                    <cfif request.isLoggedIn AND NOT request.actualUser.isMyBuddy(attributes.userData.getUsername())>
	                        <a class="btn btn-success" href="#request.sesLink#?addBuddy">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.addBuddy', language=request.language)#</a>
	                    </cfif>
	                </div>
	            </cfif>
	        <cfelse>
	            <div class="alert alert-danger">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUserBuddy.showBuddies.pleaseLogin', language=request.language)#</div>
	        </cfif>
	    </fieldset>
	</section>
</cfoutput>