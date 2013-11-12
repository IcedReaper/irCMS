<cfscript>
    if(application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Editor')) {
        attributes.navigationId = attributes.entities[1];
        attributes.version      = attributes.entities[2];

        switch(attributes.entities[3]) {
            case 'release': {
                application.cms.navigationCRUD.releaseContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case 'approve': {
                application.cms.navigationCRUD.approveContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case 'reject': {
                application.cms.navigationCRUD.rejectContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case 'delete': {
                break;
            }
            case 'revoke': {
                application.cms.navigationCRUD.revokeContentVersion(navigationId = attributes.navigationId);
                break;
            }
            default: {
                break;
            }
        }
        
        location(url="/Admin/Pages", addToken=false);
    }
    else {
        include template="/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>