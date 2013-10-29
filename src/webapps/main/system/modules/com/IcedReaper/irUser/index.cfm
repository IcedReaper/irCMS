<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irUser/main.less');

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
                case 'Registrieren': {
                    include template="register.cfm";
                    break;
                }
                default: {
                    include template="showUserProfile.cfm";
                }
            }
            break;
        }
        default: {
            break;
        }
    }
</cfscript>
