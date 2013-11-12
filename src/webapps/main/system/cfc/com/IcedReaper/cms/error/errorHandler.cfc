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
    
    public void function processNotFound(required string themeName, required struct errorStruct) {
        if(this.clearBuffer()) {
            var error = new Error(tablePrefix=variables.tablePrefix, datasource=variables.datasource);
            error.saveError('Not Found');
            error.saveDetail(key='Message', value=arguments.errorStruct.message);
            
            for(var i = 1; i <= arguments.errorStruct.tagContext.len(); i++) {
            	if(left(arguments.errorStruct.tagContext[i].raw_trace, 9) != 'org.railo') {
                	error.saveStacktrace(position     = i
                	                    ,codeHtml     = arguments.errorStruct.tagContext[i].codePrintHTML
                	                    ,templateName = arguments.errorStruct.tagContext[i].template
                	                    ,type         = arguments.errorStruct.tagContext[i].type
                	                    ,line         = arguments.errorStruct.tagContext[i].line);
                }
            }
            
            module template="/themes/#arguments.themeName#/templates/core/notFound.cfm";
        }
        else {
            // error within an error -> nice :D
        }
    }
    
    public void function processError(required string themeName, required struct errorStruct) {
        if(this.clearBuffer()) {
            var error = new Error(tablePrefix=variables.tablePrefix, datasource=variables.datasource);
            error.saveError('Error');
            if(isDefined("arguments.errorStruct.detail"))     { error.saveDetail(key='detail',     value=arguments.errorStruct.detail);     }
            if(isDefined("arguments.errorStruct.datasource")) { error.saveDetail(key='datasource', value=arguments.errorStruct.datasource); }
            if(isDefined("arguments.errorStruct.sql"))        { error.saveDetail(key='sql',        value=arguments.errorStruct.sql);        }
            if(isDefined("arguments.errorStruct.type"))       { error.saveDetail(key='type',       value=arguments.errorStruct.type);       }
            
            for(var i = 1; i <= arguments.errorStruct.tagContext.len(); i++) {
                if(left(arguments.errorStruct.tagContext[i].raw_trace, 9) != 'org.railo') {
                    error.saveStacktrace(position     = i
                                        ,codeHtml     = arguments.errorStruct.tagContext[i].codePrintHTML
                                        ,templateName = arguments.errorStruct.tagContext[i].template
                                        ,type         = arguments.errorStruct.tagContext[i].type
                                        ,line         = arguments.errorStruct.tagContext[i].line);
                }
            }
            
            module template="/themes/#arguments.themeName#/templates/core/error.cfm";
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
            out.clearBuffer();
            return true;
        }
        catch(any e) {
            return false;
        }
    }
}