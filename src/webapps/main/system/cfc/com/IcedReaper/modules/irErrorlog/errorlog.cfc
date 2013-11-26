component {
    public errorlog function init(required string tablePrefix, required string datasource) {
    	variables.tablePrefix = arguments.tablePrefix;
    	variables.datasource  = arguments.datasource;
    	
    	return this;
    }
    
    public array function filter(required numeric page, required numeric errorPerPage, required string errorType) {
    	var errors = [];
    	var qGetError = new Query().setDatasource(variables.datasource)
    	                           .setSQL("  SELECT errorId, type, recDate "
    	                                  &"    FROM #variables.tablePrefix#_errorlog "
    	                                  &"   WHERE type IN (:errorType) "
    	                                  &"ORDER BY recDate DESC "
    	                                  &"   LIMIT :limit "
    	                                  &"  OFFSET :offset ")
    	                           .addParam(name="errorType", value=arguments.errorType,                         cfsqltype="cf_sql_varchar", list="true")
                                   .addParam(name="limit",     value=arguments.errorPerPage,                      cfsqltype="cf_sql_numeric")
                                   .addParam(name="offset",    value=arguments.errorPerPage * (arguments.page-1), cfsqltype="cf_sql_numeric")
    	                           .execute()
    	                           .getResult();
        
        for(var i = 1; i <= qGetError.getRecordCount(); i++) {
        	errors[i] = {};
        	errors[i].errorId = qGetError.errorId[i];
            errors[i].type    = qGetError.type[i];
            errors[i].date    = dateConvert('utc2local', qGetError.recDate[i]);
            
            var qErrorType = new Query().setDatasource(variables.datasource)
                                        .setSQL("SELECT value "
                                               &"  FROM #variables.tablePrefix#_errorlog_detail "
                                               &" WHERE errorId = :errorId "
                                               &"   AND key     = :key "
                                               &" LIMIT 1 ")
                                        .addParam(name="errorId", value=qGetError.errorId[i], cfsqltype="cf_sql_numeric")
                                        .addParam(name="key",     value="type",               cfsqltype="cf_sql_varchar")
                                        .execute()
                                        .getResult();
            
            errors[i].errorType = qErrorType.getRecordCount() == 1 ? qErrorType.value[1] : 'undefined';
            
            var qErrorStacktrace = new Query().setDatasource(variables.datasource)
                                              .setSQL("  SELECT templateName, line "
                                                     &"    FROM #variables.tablePrefix#_errorlog_stacktrace "
                                                     &"   WHERE errorId = :errorId "
                                                     &"ORDER BY chainposition ASC "
                                                     &"   LIMIT 1 ")
                                              .addParam(name="errorId", value=qGetError.errorId[i], cfsqltype="cf_sql_numeric")
                                              .addParam(name="key",     value="message",            cfsqltype="cf_sql_varchar")
                                              .execute()
                                              .getResult();
            
            errors[i].templateName = qErrorStacktrace.getRecordCount() == 1 ? qErrorStacktrace.templateName[1] : 'undefined';
            errors[i].line         = qErrorStacktrace.getRecordCount() == 1 ? qErrorStacktrace.line[1]         : 'undefined';
        }
        
        return errors;
    }
    
    public numeric function getErrorCount(required string errorType) {
    	return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT errorId "
                                 &"  FROM #variables.tablePrefix#_errorlog "
                                 &" WHERE type IN (:errorType) ")
                          .addParam(name="errorType", value=arguments.errorType, cfsqltype="cf_sql_varchar", list="true")
                          .execute()
                          .getResult()
                          .getRecordCount();
    }
    
    public struct function getDetails(required numeric errorId) {
    	var errorData = {};
        var qGetError = new Query().setDatasource(variables.datasource)
                                   .setSQL("  SELECT errorId, type, recDate "
                                          &"    FROM #variables.tablePrefix#_errorlog "
                                          &"   WHERE errorId = :errorId ")
                                   .addParam(name="errorId", value=arguments.errorId, cfsqltype="cf_sql_numeric")
                                   .execute()
                                   .getResult();
        
        errorData.errorId = qGetError.errorId[1];
        errorData.type    = qGetError.type[1];
        errorData.date    = dateConvert('utc2local', qGetError.recDate[1]);
        
        var qErrorType = new Query().setDatasource(variables.datasource)
                                    .setSQL("SELECT key, value "
                                           &"  FROM #variables.tablePrefix#_errorlog_detail "
                                           &" WHERE errorId = :errorId "
                                           &"   AND value   <> :empty ")
                                    .addParam(name="errorId", value=qGetError.errorId[1], cfsqltype="cf_sql_numeric")
                                    .addParam(name="empty",   value='',                   cfsqltype="cf_sql_varchar")
                                    .execute()
                                    .getResult();
        
        errorData.details = [];
        for(var i = 1; i <= qErrorType.getRecordCount(); i++) {
        	errorData.details[i] = {};
            errorData.details[i].key   = qErrorType.key[i];
            errorData.details[i].value = qErrorType.value[i];
        }
        
        var qErrorStacktrace = new Query().setDatasource(variables.datasource)
                                          .setSQL("  SELECT chainposition, codeHtml, templateName, line "
                                                 &"    FROM #variables.tablePrefix#_errorlog_stacktrace "
                                                 &"   WHERE errorId = :errorId "
                                                 &"ORDER BY chainposition ASC ")
                                          .addParam(name="errorId", value=qGetError.errorId[1], cfsqltype="cf_sql_numeric")
                                          .addParam(name="key",     value="message",            cfsqltype="cf_sql_varchar")
                                          .execute()
                                          .getResult();
       
        errorData.stacktrace = [];
        for(var i = 1; i <= qErrorStacktrace.getRecordCount(); i++) {
            errorData.stacktrace[i] = {};
            errorData.stacktrace[i].chainposition = qErrorStacktrace.chainposition[i];
            errorData.stacktrace[i].codeHtml      = qErrorStacktrace.codeHtml[i];
            errorData.stacktrace[i].templateName  = qErrorStacktrace.templateName[i];
            errorData.stacktrace[i].line          = qErrorStacktrace.line[i];
        }
        
        return errorData;
    }
}