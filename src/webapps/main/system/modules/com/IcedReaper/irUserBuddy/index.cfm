<cfscript>
	param name="attributes.userName" default="";
	
	if(attributes.userName != '') {
		attributes.userData = createObject('component', 'system.cfc.com.IcedReaper.cms.user.user').init(datasource  = application.datasource.user
                                                                                                       ,tablePrefix = application.tablePrefix
                                                                                                       ,userName    = attributes.userName);
        
        if(attributes.userName != 'Guest' && attributes.userData.load()) {
            include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUserBuddy/showBuddies.cfm";
        }
	}
</cfscript>