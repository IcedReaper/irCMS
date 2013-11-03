component {
    public navigationController function init(required errorHandler errorHandler, required string tablePrefix, required string datasource) {
        variables.errorHandler = arguments.errorHandler;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        
        return this;
    }

    public array function getVersions(required numeric navigationId) {
        try {
            var versions = [];

            var qryGetVersions = new Query().setDatasource(variables.datasource)
                                            .setSQL("     SELECT cv.version, cv.navigationId, cs.statusName "
                                                   &"       FROM #variables.tablePrefix#_contentVersion cv "
                                                   &" INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                                   &"      WHERE cv.navigationId = :navigationId "
                                                   &"   ORDER BY cv.version DESC")
                                            .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                                            .execute()
                                            .getResult();

            for(var i = 1; i <= qryGetVersions.getRecordCount(); i++) {
                versions[i] = {};
                versions[i].version = qryGetVersions.version[i];
                versions[i].major   = listFirst(qryGetVersions.version[i], '.');
                versions[i].minor   = listLen(qryGetVersions.version[i], '.') == 2 ? listLast(qryGetVersions.version[i], '.') : 0;
                versions[i].status  = qryGetVersions.statusName[i];
            }

            return versions;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
}