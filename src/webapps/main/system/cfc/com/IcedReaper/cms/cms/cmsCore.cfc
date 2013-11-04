component  implements="system.interfaces.com.irCMS.cms.cmsCore" {
    public cmsCore function init(required string tablePrefix, required string datasource) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;

        return this;
    }
    
    public string function renderTemplate(required string themeName) {
        
    }

    public query function getThemes() {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT themeId, themeName "
                                 &"  FROM #variables.tablePrefix#_theme "
                                 &" WHERE active = :active ")
                          .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                          .execute()
                          .getResult();
    }

    public string function getDefaultThemeName() {
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
    
    public string function getModulePath(required string moduleName) {
		var qryModule = new Query().setDatasource(variables.datasource)
		                           .setSQL("SELECT path "
		                                  &"  FROM #variables.tablePrefix#_module "
		                                  &" WHERE moduleName = :moduleName "
		                                  &"   AND active     = :active ")
		                           .addParam(name="moduleName", value=arguments.moduleName, cfsqltype="cf_sql_varchar")
		                           .addParam(name="active",     value=true,                 cfsqltype="cf_sql_bit")
		                           .execute()
		                           .getResult();
        
        if(qryModule.getRecordCount() == 1) {
            return qryModule.path[1];
        }
        else {
            throw(type="notFound", message="Path of Module not found", detail=arguments.moduleName);
        }
    }
}