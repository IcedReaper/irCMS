<cfscript>
    attributes.moduleData.isMyUser = request.actualUser.getUsername() == attributes.entities[1];
    attributes.moduleData.userName = attributes.entities[1];

    if(isDefined("form") && ! form.isEmpty() && attributes.moduleData.isMyUser) {
        attributes.userUpdate = application.user.controller.updateUser(userName=attributes.moduleData.userName, userData=form);
    }

    attributes.moduleData.userData = createObject('component', 'system.cfc.com.IcedReaper.modules.irUser.irUser').init(errorHandler = application.cms.errorHandler
                                                                                                                    ,datasource     = application.datasource.user
                                                                                                                    ,tablePrefix    = application.tablePrefix
                                                                                                                    ,userName       = attributes.moduleData.userName);
    if(attributes.moduleData.userName != 'Guest' && attributes.moduleData.userData.load()) {
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/userProfile.cfm";
    }
    else {
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/userNotFound.cfm";
    }
</cfscript>