<cfscript>
    attributes.moduleData.isMyUser = request.actualUser.getUsername() == attributes.entities[1];
    attributes.moduleData.userName = attributes.entities[1];
    attributes.moduleData.userData = createObject('component', 'system.cfc.com.IcedReaper.modules.irUser.irUser').init(errorHandler = application.cms.errorHandler
                                                                                                                    ,datasource   = application.datasource.user
                                                                                                                    ,tablePrefix  = application.tablePrefix
                                                                                                                    ,userName     = attributes.moduleData.userName);
    if(attributes.moduleData.userData.load()) {
        include template="/themes/#request.themeName#/templates/modules/irUser/userProfile.cfm";
    }
    else {
        include template="/themes/#request.themeName#/templates/modules/irUser/userNotFound.cfm";
    }
</cfscript>