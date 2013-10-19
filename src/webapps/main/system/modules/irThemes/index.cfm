<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    application.themes[request.themeName].cfstatic.include('/js/modules/irThemes.less');

    //include template="/themes/#request.themeName#/templates/modules/irThemes/dspOverview.cfm";
</cfscript>