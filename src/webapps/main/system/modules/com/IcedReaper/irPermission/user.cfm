<cfscript>
	attributes.userName  = attributes.entities[2];
    attributes.roleList  = application.security.permissionCRUD.getRoleList();
    attributes.groupList = application.security.permissionCRUD.getGroupList();
        
    attributes.user = createObject("component", "system.cfc.com.IcedReaper.cms.user.user").init(tablePrefix = application.tablePrefix
                                                                                               ,datasource  = application.datasource.user
                                                                                               ,userName    = attributes.userName);
	attributes.user.load();
	
	if(request.actualUser.hasPermission(groupName='irPermission', roleName='Editor')) {
	    if(isDefined("form") && ! form.isEmpty()) {
            switch(form.action) {
                case 'save': {
                    application.security.permissionCRUD.updateUserPermission(userId=attributes.user.getUserId(), userRoles=form);
                    attributes.saveSuccessfull = true;
                    break;
                }
            }
        }
        
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irPermission/user.cfm";
	}
    else {
        include "/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>