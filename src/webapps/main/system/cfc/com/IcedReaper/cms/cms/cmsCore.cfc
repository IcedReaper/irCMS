component  implements="system.interfaces.com.irCMS.cms.cmsCore" {
    public cmsCore function init(required errorHandler errorHandler, required string tablePrefix, required string datasource) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.errorHandler = arguments.errorHandler;

        return this;
    }
    
    public string function renderTemplate(required string themeName) {
        
    }

    public query function getThemes() {
        try {
            return new Query().setDatasource(variables.datasource)
                              .setSQL("SELECT themeId, themeName "
                                     &"  FROM #variables.tablePrefix#_theme "
                                     &" WHERE active = :active ")
                              .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                              .execute()
                              .getResult();
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public string function getDefaultThemeName() {
        try {
            return new Query().setDatasource(variables.datasource)
                              .setSQL("SELECT themeName "
                                     &"  FROM #variables.tablePrefix#_theme "
                                     &" WHERE active = :active "
                                     &"   AND defaultTheme = :default ")
                              .addParam(name="active",  value=true, cfsqltype="cf_sql_bit")
                              .addParam(name="default", value=true, cfsqltype="cf_sql_bit")
                              .execute()
                              .getResult()
                              .themeName[1];
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
    
    public string function getModulePath(required string moduleName) {
    	try {
    		var qryModule = new Query().setDatasource(variables.datasource)
    		                           .setSQL("SELECT path "
    		                                  &"  FROM #variables.tablePrefix#_module "
    		                                  &" WHERE moduleName = :moduleName "
    		                                  &"   AND active     = :active ")
    		                           .addParam(name="moduleName", value=arguments.moduleName, cfsqltype="cf_sql_varchar")
    		                           .addParam(name="active",     value=true,                 cfsqltype="cf_sql_bit")
    		                           .execute()
    		                           .getResult();
    	   return qryModule.getRecordCount() == 1 ? qryModule.path[1] : '';
    	}
    	catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
}