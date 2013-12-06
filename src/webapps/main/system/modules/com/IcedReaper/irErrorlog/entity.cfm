<cfscript>
    attributes.errorLog = createObject('component', 'system.cfc.com.IcedReaper.modules.irErrorlog.errorlog').init(tablePrefix=application.tablePrefix, datasource=application.datasource.user);
    
    attributes.errorId   = attributes.entities[2];
    attributes.errorData = attributes.errorLog.getDetails(errorId=attributes.errorId);
    
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irErrorlog/details.cfm";
</cfscript>