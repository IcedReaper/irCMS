<cfscript>
    attributes.dashboardData = attributes.navigationCRUD.getDashboardData();
    
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/dashboard.cfm";
</cfscript>