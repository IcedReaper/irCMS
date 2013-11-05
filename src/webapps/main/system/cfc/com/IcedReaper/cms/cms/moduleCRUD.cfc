component {
    public moduleCRUD function init(required string tablePrefix, required string datasource) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        
        return this;
    }

    public array function getActive() {
        var modules = [];
        var qryGetModule = new Query().setDatasource(variables.datasource)
                                      .setSQL(" SELECT * "
                                            &"    FROM #variables.tablePrefix#_module "
                                            &"   WHERE active = :active "
                                            &"ORDER BY moduleName")
                                      .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                                      .execute()
                                      .getResult();

        for(var i = 1; i <= qryGetModule.getRecordCount(); i++) {
            modules[i] = {};
            modules[i].id           = qryGetModule.moduleId[i];
            modules[i].name         = qryGetModule.moduleName[i];
            modules[i].active       = qryGetModule.active[i];
            modules[i].systemModule = qryGetModule.systemModule[i];
        }

        return modules;
    }

    public array function getAll() {
        var modules = [];
        var qryGetModule = new Query().setDatasource(variables.datasource)
                                      .setSQL(" SELECT * "
                                            &"    FROM #variables.tablePrefix#_module "
                                            &"ORDER BY moduleName")
                                      .execute()
                                      .getResult();

        for(var i = 1; i <= qryGetModule.getRecordCount(); i++) {
            modules[i] = {};
            modules[i].id           = qryGetModule.moduleId[i];
            modules[i].name         = qryGetModule.moduleName[i];
            modules[i].active       = qryGetModule.active[i];
            modules[i].systemModule = qryGetModule.systemModule[i];
        }

        return modules;
    }

    public array function getInactive() {
        var modules = [];
        var qryGetModule = new Query().setDatasource(variables.datasource)
                                      .setSQL(" SELECT * "
                                            &"    FROM #variables.tablePrefix#_module "
                                            &"   WHERE active = :active "
                                            &"ORDER BY moduleName")
                                      .addParam(name="active", value=false, cfsqltype="cf_sql_bit")
                                      .execute()
                                      .getResult();

        for(var i = 1; i <= qryGetModule.getRecordCount(); i++) {
            modules[i] = {};
            modules[i].id           = qryGetModule.moduleId[i];
            modules[i].name         = qryGetModule.moduleName[i];
            modules[i].active       = qryGetModule.active[i];
            modules[i].systemModule = qryGetModule.systemModule[i];
        }

        return modules;
    }

    public boolean function install(required struct moduleData, required numeric userId) {
    	if(fileExists('/system/modules/#arguments.moduleData.modulePath#/index.cfm')) {
    		new Query().setDatasource(variables.datasource)
    		           .setSQL("INSERT INTO #variables.tablePrefix#_module "
    		                  &"            ("
    		                  &"              moduleName, "
                              &"              path, "
                              &"              userId, "
                              &"              systemModule "
    		                  &"            )"
                              &"     VALUES ("
                              &"              :moduleName, "
                              &"              :path, "
                              &"              :userId, "
                              &"              :systemModule "
                              &"            )")
    		           .addParam(name="moduleName",   value=arguments.moduleData.moduleName,   cfsqltype="cf_sql_varchar")
                       .addParam(name="path",         value=arguments.moduleData.modulePath,   cfsqltype="cf_sql_varchar")
                       .addParam(name="userId",       value=arguments.userId,                  cfsqltype="cf_sql_numeric")
                       .addParam(name="systemModule", value=arguments.moduleData.systemModule, cfsqltype="cf_sql_bit")
    		           .execute();
    		
            return true;
    	}
    	else {
    		return false;
    	}
    }

    public boolean function deInstall(required string moduleName) {
        new Query().setDatasource(variables.datasource)
                   .setSQL("UPDATE #variables.tablePrefix#_module "
                          &"   SET active=:inActive "
                          &" WHERE moduleName=:moduleName ")
                   .addParam(name="moduleName",   value=arguments.moduleName, cfsqltype="cf_sql_varchar")
                   .addParam(name="inActive",     value=false,                cfsqltype="cf_sql_varchar")
                   .execute();
        
        return true;
    }
}