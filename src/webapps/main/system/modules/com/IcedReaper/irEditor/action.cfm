<cfscript>
    if(application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Editor')) {
        attributes.navigationId = attributes.entities[1];
        attributes.version      = attributes.entities[2];

        switch(attributes.entities[3]) {
            case 'Freigeben': {
                if(! applicaton.cms.navigationCRUD.isNavigationInUse(navigationId=attributes.navigationId, version=attributes.version)) {
                    applicaton.cms.navigationCRUD.releaseNavigation(navigationId=attributes.navigationId, version=attributes.version);
                }
                else {
                    module template="/themes/#request.themeName#/core/message.cfm" headline="Fehler!" text="Die Seite ist bereits in Benutzung und kann nicht weiter freigegeben werden.";
                }
                break;
            }
            case 'Löschen': {
                if(! applicaton.cms.navigationCRUD.isNavigationInUse(navigationId=attributes.navigationId, version=attributes.version)) {
                    applicaton.cms.navigationCRUD.deleteNavigation(navigationId=attributes.navigationId, version=attributes.version);
                }
                else {
                    module template="/themes/#request.themeName#/core/message.cfm" headline="Fehler!" text="Die Seite ist bereits in Benutzung und kann nicht gelöscht werden.";
                }
                break;
            }
            default: {
                module template="/themes/#request.themeName#/core/message.cfm" headline="Fehler!" text="Die Angegebene Aktion konnte nicht gefunden werden.";
                break;
            }
        }
    }
    else {
        include template="/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>