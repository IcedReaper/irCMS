<cfscript>
    attributes.searchResults = application.cms.themeController.search(themeName='');
    include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irThemes/overview.cfm";
</cfscript>