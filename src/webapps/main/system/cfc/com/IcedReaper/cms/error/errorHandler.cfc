component  implements="system.interfaces.com.irCMS.error.errorHandler" {
    public errorHandler function init(required string tablePrefix, required string datasource, required tools tools) {
        variables.tablePrefix = arguments.tablePrefix;
        variables.datasource  = arguments.datasource;
        variables.tools       = arguments.tools;
        
        return this;
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
    
    public void function logError(required string errorType, required struct errorData) {
        var error = new Error(tablePrefix=variables.tablePrefix, datasource=variables.datasource);
        error.saveError(arguments.errorType);
        
        for(var element in arguments.errorData) {
            if(element == 'message' || element == 'detail' || element == 'datasource' || element == 'sql' || element == 'type') {
                if(arguments.errorData[element] != '') {
                    error.saveDetail(key=element, value=arguments.errorData[element]);
                }
            }
            else if(element == 'tagContext') {
                for(var i = 1; i <= arguments.errorData[element].len(); i++) {
                    if(left(arguments.errorData[element][i].raw_trace, 9) != 'org.railo') {
                        error.saveStacktrace(position     = i
                                            ,codeHtml     = arguments.errorData[element][i].codePrintHTML
                                            ,templateName = arguments.errorData[element][i].template
                                            ,type         = arguments.errorData[element][i].type
                                            ,line         = arguments.errorData[element][i].line);
                    }
                }
            }
        }
    }
    
    public void function processNotFound(required string themeName, required struct errorStruct) {
        if(this.clearBuffer()) {
            this.logError(errorType='Not Found', errorData=arguments.errorStruct);
            
            module template="/themes/#arguments.themeName#/templates/core/notFound.cfm";
        }
    }
    
    public void function processError(required string themeName, required struct errorStruct) {
        if(this.clearBuffer()) {
            this.logError(errorType='Error', errorData=arguments.errorStruct);
            
            module template="/themes/#arguments.themeName#/templates/core/error.cfm";
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
            out.clearBuffer();
            return true;
        }
        catch(any e) {
            return false;
        }
    }
}