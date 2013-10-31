<cfscript>
	param name="attributes.userName" default="";
	
	if(attributes.userName != '') {
		attributes.userData = createObject('component', 'system.cfc.com.IcedReaper.modules.irUser.irUser').init(errorHandler = application.cms.errorHandler
                                                                                                               ,datasource   = application.datasource.user
                                                                                                               ,tablePrefix  = application.tablePrefix
                                                                                                               ,userName     = attributes.userName);
        
        if(attributes.userName != 'Guest' && attributes.userData.load()) {
            include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUserBuddies/showBuddies.cfm";
        }
	}
</cfscript>