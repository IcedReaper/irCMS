<cfscript>
    attributes.moduleData.searchResults = application.user.search.forUser(userName='');
    include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/searchResults.cfm";
</cfscript>