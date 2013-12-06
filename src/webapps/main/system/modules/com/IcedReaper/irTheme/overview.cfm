<cfscript>
    attributes.searchResults = application.cms.themeCRUD.search(themeName='');
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irThemes/overview.cfm";
</cfscript>