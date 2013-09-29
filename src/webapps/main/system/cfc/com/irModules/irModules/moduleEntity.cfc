component {
    public moduleEntity function init(required errorHandler errorHandler, required string datasource, required string tablePrefix, required string entityName) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.entityName   = arguments.entityName;
        variables.errorHandler = arguments.errorHandler;

        return this;
    }

    public boolean function loadEntity() {
        try {
            var qryGetEntity = new Query();
            qryGetEntity.setDatasource(variables.datasource);
            qryGetEntity.setSQL("SELECT * FROM #variables.tablePrefix#_irModules_entity WHERE entityName=:entityName AND active=:active");
            qryGetEntity.addParam(name="entityName", value=variables.entityName, cfsqltype="cf_sql_varchar");
            qryGetEntity.addParam(name="active",     value=true                  cfsqltype="cf_sql_bit");

            variables.entity = qryGetEntity.execute().getResult();
            return variables.entity.recordCount == 1;
        }
        catch(any e) {
            return false;
        }
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