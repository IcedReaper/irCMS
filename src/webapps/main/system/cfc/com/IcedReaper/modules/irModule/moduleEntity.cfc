component {
    public moduleEntity function init(required string datasource, required string tablePrefix, required string entityName) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.entityName   = arguments.entityName;

        return this;
    }

    public boolean function loadEntity() {
        variables.entity = new Query().setDatasource(variables.datasource)
                                      .setSQL("SELECT * "
                                             &"  FROM #variables.tablePrefix#_modules_irModules_entity "
                                             &" WHERE entityName = :entityName "
                                             &"   AND active     = :active")
                                      .addParam(name="entityName", value=variables.entityName, cfsqltype="cf_sql_varchar")
                                      .addParam(name="active",     value=true                  cfsqltype="cf_sql_bit")
                                      .execute()
                                      .getResult();
         
        return variables.entity.recordCount == 1;
    }

    public string function getName() {
        return '';
    }

    public string function getDescription() {
        return '';
    }

    public array function getTags() {
        return [];
    }
}