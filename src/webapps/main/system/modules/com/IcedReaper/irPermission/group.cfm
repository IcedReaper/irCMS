<cfscript>
    attributes.groupName = attributes.entities[1];
    attributes.editable  = request.actualUser.hasPermission(groupName='irPermission', roleName='Editor');
</cfscript>