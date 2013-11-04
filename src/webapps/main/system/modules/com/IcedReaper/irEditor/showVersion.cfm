<cfscript>
    attributes.navigationId = attributes.entities[1];
    attributes.version      = attributes.entities[2];

    attributes.pageToShow = createObject("component", "system.cfc.com.IcedReaper.modules.irEditor.navigationVersion").init(tablePrefix  = application.tablePrefix
                                                                                                                          ,datasource   = application.datasource.user
                                                                                                                          ,navigationId = attributes.navigationId
                                                                                                                          ,version      = attributes.version);
    
    if(attributes.pageToShow.load()) {
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/showVersionOfPage.cfm";
    }
    else {
        //throw(type="Navigation load failed", detail="handleSes");
    }
</cfscript>