component {
    public error function init(required string tablePrefix, required string datasource) {
    	variables.tablePrefix = arguments.tablePrefix;
    	variables.datasource  = arguments.datasource;
    	
    	variables.errorId = new Query().setDatasource(variables.datasource)
                                       .setSQL("SELECT nextVal('#variables.tablePrefix#_errorlog_errorid_seq') errorId")
    	                               .execute()
    	                               .getResult()
    	                               .errorId[1];
    	
    	variables.errorSaved = false;
    	
    	return this;
    }
    
    public boolean function saveError(required string type) {
    	new Query().setDatasource(variables.datasource)
                   .setSQL("INSERT INTO #variables.tablePrefix#_errorLog "
    	                  &"            ( "
    	                  &"              errorId, "
    	                  &"              type "
    	                  &"            ) "
    	                  &"     VALUES "
                          &"            ( "
                          &"              :errorId, "
                          &"              :type "
                          &"            ) ")
                   .addParam(name="errorId", value=variables.errorId, cfsqltype="cf_sql_numeric")
                   .addParam(name="type",    value=arguments.type,    cfsqltype="cf_sql_varchar")
                   .execute();
        
        variables.errorSaved = true;
        return true;
    }
    
    public boolean function saveDetail(required string key, required string value) {
    	if(variables.errorSaved) {
    		new Query().setDatasource(variables.datasource)
    		           .setSQL("INSERT INTO #variables.tablePrefix#_errorLog_Detail "
                              &"            ( "
                              &"              errorId, "
                              &"              key, "
                              &"              value "
                              &"            ) "
                              &"     VALUES "
                              &"            ( "
                              &"              :errorId, "
                              &"              :key, "
                              &"              :value "
                              &"            ) ")
      		           .addParam(name="errorId", value=variables.errorId, cfsqltype="cf_sql_numeric")
                       .addParam(name="key",     value=arguments.key,     cfsqltype="cf_sql_varchar")
                       .addParam(name="value",   value=arguments.value,   cfsqltype="cf_sql_varchar")
          	           .execute();
          	
          	return true;
    	}
    	else {
    		return false;
    	}
    }
    
    public boolean function saveStacktrace(required numeric position, required string codeHtml, required string templateName, required string type, required numeric line) {
        if(variables.errorSaved) {
            new Query().setDatasource(variables.datasource)
                       .setSQL("INSERT INTO #variables.tablePrefix#_errorLog_Detail "
                              &"            ( "
                              &"              errorId, "
                              &"              chainposition, "
                              &"              codeHtml, "
                              &"              templateName, "
                              &"              type, "
                              &"              line "
                              &"            ) "
                              &"     VALUES "
                              &"            ( "
                              &"              :errorId, "
                              &"              :chainposition, "
                              &"              :codeHtml, "
                              &"              :templateName, "
                              &"              :type, "
                              &"              :line "
                              &"            ) ")
                       .addParam(name="errorId",       value=variables.errorId,      cfsqltype="cf_sql_numeric")
                       .addParam(name="chainposition", value=arguments.position,     cfsqltype="cf_sql_numeric")
                       .addParam(name="codeHtml",      value=arguments.codeHtml,     cfsqltype="cf_sql_varchar")
                       .addParam(name="templateName",  value=arguments.templateName, cfsqltype="cf_sql_varchar")
                       .addParam(name="type",          value=arguments.type,         cfsqltype="cf_sql_varchar")
                       .addParam(name="line",          value=arguments.line,         cfsqltype="cf_sql_numeric")
                       .execute();
            
            return true;
        }
        else {
            return false;
        }
    }
}