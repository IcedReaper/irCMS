<cfscript>
    if(request.actualUser.hasPermission(groupName='irEditor', roleName='Editor')) {
        attributes.pages = attributes.navigationCRUD.getCompleteSitemap(coreNavigation=application.cms.navigationCRUD, language=request.language);
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/sort.cfm";
    }
    else {
        throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irEditor;Editor");
    }
</cfscript>