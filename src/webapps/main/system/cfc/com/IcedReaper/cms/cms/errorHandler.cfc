component  implements="system.interfaces.com.irCMS.cms.errorHandler" {
    public errorHandler function init(required string tablePrefix, required string datasource, required tools tools) {
        variables.tablePrefix = arguments.tablePrefix;
        variables.datasource  = arguments.datasource;
        variables.tools       = arguments.tools;
        
        return this;
    }
    
    public boolean function logError(required string message, required string detail) {
    	try {
    		new Query().setDatasource(variables.datasource)
                       .setSQL("INSERT INTO #variables.tablePrefix#_errorLog (message, detail, recDate) VALUES (:message, :detail, :recDate)")
                       .addParam(name="message", value=arguments.message, cfsqltype="cf_sql_varchar")
                       .addParam(name="detail",  value=arguments.detail,  cfsqltype="cf_sql_varchar")
                       .addParam(name="recDate", value=now(),             cfsqltype="cf_sql_timeStamp")
                       .execute();
            
            return true;
        }
        catch(any e) {
        	writeDump(e);
        	abort;
            // error within an error -> nice one :D
            
            return false;
        }
    }
    
    public query function getError(required numeric pageNumber, required numeric errorsPerPage) {
    	return new Query().setDatasource(variables.datasource)
                          .setSQL("   SELECT * "
                                 &"     FROM #variables.tablePrefix#_errorLog "
                                 &" ORDER BY recDate DESC "
                                 &"   OFFSET :offset "
                                 &"    LIMIT :perPage")
                          .addParam(name="offset",  value=(arguments.pageNumber-1) * arguments.errorsPerPage, cfsqltype="cf_sql_numeric")
                          .addParam(name="perPage", value=errorsPerPage,                                      cfsqltype="cf_sql_numeric")
                          .execute()
                          .getResult();
    }
    
    public void function processNotFound(required string themeName, required string type, required string detail) {
        if(clearBuffer()) {
            writeDump(arguments);
        	module template="/icedreaper/themes/#arguments.themeName#/templates/core/notFound.cfm";
        }
        else {
        	// error within an error -> nice :D
        }
    }
    
    public void function processError(required string themeName, required string message, required string detail) {
        if(clearBuffer()) {
        	this.logError(message=arguments.message, detail=arguments.detail);
            writeDump(arguments);
            module template="/icedreaper/themes/#arguments.themeName#/templates/core/error.cfm";
        }
        else {
            // error within an error -> nice :D
        }
    }
    
    private boolean function clearBuffer() {
        try {
        	// this is the 'local' page context
            var out = getPageContext().getOut();
            // iterate over this to catch the parent object until we get to a coldfusion.runtime.NeoJspWriter
            while (getMetaData(out).getName() == 'coldfusion.runtime.NeoBodyContent'){
                out = out.getEnclosingWriter();
            }
            //out.clearBuffer();
            return true;
        }
        catch(any e) {
        	return false;
        }
    }
}