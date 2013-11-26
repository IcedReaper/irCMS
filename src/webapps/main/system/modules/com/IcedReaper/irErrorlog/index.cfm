<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";
    
    attributes.showPerPage = 30;
    
    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irErrorlog/main.less');
    
    switch(attributes.entities.len()) {
    	case 2: {
            switch(attributes.entities[1]) {
                case 'Page': {
                    attributes.page = attributes.entities[2];
                    include template="overview.cfm";
                    break;
                }
                case 'Error': {
                    include template="entity.cfm";
                    break;
                }
            }
            break;
        }
    	default: {
            attributes.page = 1;
    		include template="overview.cfm";
    		break;
    	}
    }
</cfscript>