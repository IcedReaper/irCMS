<cfscript>
    attributes.isMyUser = request.actualUser.getUsername() == attributes.entities[1];
    attributes.userName = attributes.entities[1];

    if(isDefined("form") && ! form.isEmpty() && attributes.isMyUser) {
        attributes.userUpdate = application.user.userCRUD.updateUser(userName=attributes.userName, userData=form);
    }

    attributes.userData = createObject('component', 'system.cfc.com.IcedReaper.cms.user.user').init(datasource   = application.datasource.user
                                                                                                   ,tablePrefix  = application.tablePrefix
                                                                                                   ,userName     = attributes.userName);
    if(attributes.userName != 'Guest' && attributes.userData.load()) {
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/userProfile.cfm";
    }
    else {
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/userNotFound.cfm";
    }
</cfscript>