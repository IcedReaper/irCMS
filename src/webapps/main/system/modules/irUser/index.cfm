<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    attributes.moduleData.isMyUser = request.actualUser.getUsername() == attributes.entities[1];
    attributes.moduleData.userName = attributes.entities[1];

    application.themes[request.themeName].cfstatic.include('/css/modules/irUser/main.less');

    switch(attributes.entities.len()) {
        case 0: {
            switch(attributes.show) {
                case 'Top': {
                    include template="mostActive.cfm";
                    break;
                }
                default: {
                    include template="overview.cfm";
                    break;
                }
            }
            break;
        }
        case 1: {
            switch(attributes.entities[1]) {
                default: {
                    include template="showUserProfile.cfm";
                }
            }
            break;
        }
        case 2: {
            switch(attributes.entities[2]) {
                case 'Groups': {
                    include template="userGroups.cfm";
                }
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