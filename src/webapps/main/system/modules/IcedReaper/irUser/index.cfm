<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

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
            // e.g. Search/Page/2
            switch(attributes.entities[1]) {
                case 'Suche': {
                    include template="search.cfm";
                    break;
                }
            }
            break;
        }
    }
</cfscript>