<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    attributes.moduleData.isMyUser = request.actualUser.getUsername() == attributes.entities[1];
    attributes.moduleData.userName = attributes.entities[1];

    application.themes[request.themeName].cfstatic.include('/css/modules/irUser/main.less');

    switch(attributes.entities.len()) {
        case 0: {
            include template="overview.cfm";
            break;
        }
        case 1: {
            switch(attributes.entities[1]) {
                case 'Suche': {
                    include template="search.cfm";
                    break;
                }
                case 'Übersicht': {
                    include template="overview.cfm";
                    break;
                }
                default: {
                    include template="showUserProfile.cfm";
                }
            }
            break;
        }
        case 2: {
            switch(attributes.entities[2]) {
                default: {
                    break;
                }
            }
        }
        default: {
            break;
        }
    }
</cfscript>