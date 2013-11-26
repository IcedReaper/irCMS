<cfscript>
    attributes.errorLog = createObject('component', 'system.cfc.com.IcedReaper.modules.irErrorlog.errorlog').init(tablePrefix=application.tablePrefix, datasource=application.datasource.user);
	
    attributes.overview   = attributes.errorlog.filter(page=attributes.page, errorPerPage=attributes.showPerPage, errorType='Error,Not Found');
    attributes.errorCount = attributes.errorlog.getErrorCount(errorType='Error,Not Found');
    
    attributes.pageCount = ceiling(attributes.errorCount/attributes.showPerPage);
    
    include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irErrorlog/overview.cfm";
</cfscript>