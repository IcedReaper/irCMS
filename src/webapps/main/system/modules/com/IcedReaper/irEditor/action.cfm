<cfscript>
    if(application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Editor')) {
        attributes.navigationId = attributes.entities[1];
        attributes.majorVersion = attributes.entities[3];
        attributes.minorVersion = attributes.entities[4];

        switch(attributes.entities[2]) {
            case 'release': {
                application.cms.navigationCRUD.releaseContentVersion(navigationId = attributes.navigationId,
                                                                     majorVersion = attributes.majorVersion,
                                                                     minorVersion = attributes.minorVersion);
                break;
            }
            case 'approve': {
                application.cms.navigationCRUD.approveContentVersion(navigationId = attributes.navigationId,
                                                                     majorVersion = attributes.majorVersion,
                                                                     minorVersion = attributes.minorVersion);
                break;
            }
            case 'reject': {
                application.cms.navigationCRUD.rejectContentVersion(navigationId = attributes.navigationId,
                                                                    majorVersion = attributes.majorVersion,
                                                                    minorVersion = attributes.minorVersion);
                break;
            }
            case 'delete': {
                application.cms.navigationCRUD.deleteContentVersion(navigationId = attributes.navigationId,
                                                                    majorVersion = attributes.majorVersion,
                                                                    minorVersion = attributes.minorVersion);
                break;
            }
            case 'revoke': {
                application.cms.navigationCRUD.revokeContentVersion(navigationId = attributes.navigationId,
                                                                    majorVersion = attributes.majorVersion,
                                                                    minorVersion = attributes.minorVersion);
                break;
            }
            default: {
                break;
            }
        }
        
        location(url=attributes.sesLink, addToken=false);
    }
    else {
        throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irEditor;Editor");
    }
</cfscript>