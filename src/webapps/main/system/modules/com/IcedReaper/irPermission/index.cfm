<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irPermissions/main.less');
    
    if(request.actualUser.hasPermission(groupName='irPermission', roleName='Reader')) {
        switch(attributes.entities.len()) {
        	case 1: {
                // show users of specific group
                include "group.cfm";
                break;
        	}
        	case 2: {
				// show permissions of specific user
				include "user.cfm";
        		break;
        	}
        	default: {
        		// overview
        		include "overview.cfm";
        		break;
        	}
        }
    }
    else {
        throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irPermission;Reader");
    }
</cfscript>