<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    application.themes[request.themeName].cfstatic.include('/js/modules/irGallery.less');

    //include template="/themes/#request.themeName#/templates/modules/irGallery/dspOverview.cfm";
</cfscript>