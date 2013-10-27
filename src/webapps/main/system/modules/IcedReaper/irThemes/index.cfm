<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    application.themes[request.themeName].cfstatic.include('/css/modules/irThemes/main.less');

    //include template="/themes/#request.themeName#/templates/modules/irThemes/dspOverview.cfm";
</cfscript>