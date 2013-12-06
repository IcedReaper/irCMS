<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irUser/main.less');

    switch(attributes.entities.len()) {
        case 0: {
            include "overview.cfm";
            break;
        }
        case 1: {
            switch(attributes.entities[1]) {
                case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.links.search', language=request.language): {
                    include "search.cfm";
                    break;
                }
                case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.links.register', language=request.language): {
                    include "register.cfm";
                    break;
                }
                default: {
                    include "showUserProfile.cfm";
                }
            }
            break;
        }
        default: {
            break;
        }
    }
</cfscript>
