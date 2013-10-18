component  implements="system.interfaces.com.irCMS.errorHandler" {
    public errorHandler function init(required string tablePrefix, required string datasource) {
        variables.tablePrefix = arguments.tablePrefix;
        variables.datasource  = arguments.datasource;
        variables.tools       = arguments.tools;
        
        return this;
    }
    
    public boolean function logError(required string message, required string detail, numeric errorId=0) {
    	try {
    		if(arguments.errorId == 0) {
        		
        	}
            var qInsError = new Query().setDatasource(variables.datasource)
                                       .setSQL("INSERT INTO #variables.tablePrefix#_errorLog (errorId, message, detail, recDate) VALUES (:errorId, :message, :detail, :recDate)")
                                       .addParam(name="errorId", value=arguments.errorId, cfsqltype="cf_sql_numeric")
                                       .addParam(name="message", value=arguments.message, cfsqltype="cf_sql_varchar")
                                       .addParam(name="detail",  value=arguments.detail,  cfsqltype="cf_sql_varchar")
                                       .addParam(name="recDate", value=now(),             cfsqltype="cf_sql_timeStamp")
                                       .execute();
            
            return true;
        }
        catch(any e) {
            // error within an error -> nice :D
            
            return false;
        }
    }
    
    public query function getError() {
    	return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT * FROM #variables.tablePrefix#_errorLog ORDER BY recDate DESC")
                          .execute()
                          .getResult();
    }
    
    public void function processNotFound(required string themeName, required string type, required string detail) {
        if(clearBuffer()) {
            writeDump(arguments);
        	module template="/icedreaper/themes/#arguments.themeName#/templates/default/notFound.cfm";
        }
        else {
        	// error within an error -> nice :D
        }
    }
    
    public void function processError(required string themeName, required string message, required string detail) {
        if(clearBuffer()) {
            writeDump(arguments);
            module template="/icedreaper/themes/#arguments.themeName#/templates/default/error.cfm";
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