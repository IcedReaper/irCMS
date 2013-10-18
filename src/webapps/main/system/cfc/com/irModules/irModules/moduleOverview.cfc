component {
    public moduleOverview function init(required errorHandler errorHandler, required string datasource, required string tablePrefix) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.errorHandler = arguments.errorHandler;

        return this;
    }

    public array function filter(required numeric pageNumber, require numeric numberPerPage) {
        try {
            var qFilterModules = new Query().setDatasource(variables.datasource)
                                            .setSQL("         SELECT mod.entityId, mod.entityName, mod.userName modUsername, mod.creationDate, usr.userName, usr.userId "
                                                   &"           FROM irCMS_irModules_entity mod "
                                                   &"     INNER JOIN irCMS_irModules_status status ON mod.statusId = status.statusId "
                                                   &"LEFT OUTER JOIN irCMS_user             usr    ON mod.userId   = usr.userId "
                                                   &"          WHERE status.online = :online "
                                                   &"          LIMIT :numberPerPage OFFSET :from ")
                                            .addParam(name="online",        value=true,                                             cfsqltype="cf_sql_bit")
                                            .addParam(name="numberPerPage", value=arguments.numberPerPage,                          cfsqltype="cf_sql_numeric")
                                            .addParam(name="from",          value=(arguments.pageNumber-1)*arguments.numberPerPage, cfsqltype="cf_sql_numeric")
                                            .execute()
                                            .getResult();

            var results = [];
            for(var i = 1; i <= qFilterModules.recordCount; i++) {
                results[i] = {};
                results[i].name         = qFilterModules.entityName[i];
                results[i].creator      = qFilterModules.modUsername[i] == '' ? qFilterModules.userName[i] : qFilterModules.modUsername[i];
                results[i].userId       = qFilterModules.modUsername[i] == '' ? qFilterModules.userId[i]   : 0;

                var localDate = dateConvert('utc2local', qFilterModules.creationDate[i]);
                results[i].creationDate = dateFormat(localDate, 'DD.MMM YYYY') & ' ' & timeFormat(localDate, 'HH:MM:SS');
                results[i].tags         = [];

                var qGetTags = new Query().setDatasource(variables.datasource)
                                            .setSQL("    SELECT tagName "
                                                   &"      FROM irCMS_irModules_tag tag "
                                                   &"INNER JOIN irCMS_irModules_entityTag entityTag ON tag.tagId = entityTag.tagId "
                                                   &"     WHERE entityTag.entityId=:entityId")
                                            .addParam(name="entityId", value=qFilterModules.entityId[i], cfsqltype="cf_sql_numeric")
                                            .execute()
                                            .getResult();

                for(var j = 1; j <= qGetTags.recordCount; j++) {
                    results[i].tags[j] = qGetTags.tagName[j];
                }
            }

            return results;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='icedreaper_light', message=e.message, detail=e.detail);
            abort;
        }
    }

    public array function getTopModules(required numeric topCounter) {
        return [];
    }

    public boolean function addTagToModule(required string entityName, required string tagName) {

    }

    public boolean function removeTagFromModule(required string entityName, required string tagName) {
        
    }
}