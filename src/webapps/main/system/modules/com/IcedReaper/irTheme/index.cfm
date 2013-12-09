<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irThemes/main.less');
    
    if(application.security.permission.hasPermission(userName=request.userName, groupName='irTheme', roleName='Reader')) {
        switch(attributes.entities.len()) {
        	case 0: {
        		include "overview.cfm";
        		break;
        	}
            case 1: {
                switch(attributes.entities[1]) {
                    case 'Suche': {
                        include "search.cfm";
                        break;
                    }
                    case 'Neu': {
                        include "create.cfm";
                    }
                    default: {
                        include "showTheme.cfm";
                    }
                }
                break;
            }
        }
    }
    else {
        throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irTheme;Reader");
    }
</cfscript>