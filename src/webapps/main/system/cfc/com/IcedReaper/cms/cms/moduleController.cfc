component {
    public moduleController function init(required string tablePrefix, required string datasource) {
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

    public boolean function install() {
        return true;
    }

    public boolean function deInstall() {
        return true;
    }
}