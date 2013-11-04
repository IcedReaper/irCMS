component {
    public navigationController function init(required string tablePrefix, required string datasource) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        
        return this;
    }

    public array function getVersions(required numeric navigationId) {
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

    public numeric function createNewMajorVersion(required numeric userId, required numeric navigationId) {
        var qryGetLastVersion = new Query().setDatasource(variables.datasource)
                                           .setSQL("  SELECT * "
                                                  &"    FROM #variables.tablePrefix#_contentVersion "
                                                  &"   WHERE navigationId = :navigationId "
                                                  &"ORDER BY version DESC "
                                                  &"   LIMIT 1")
                                           .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                                           .execute()
                                           .getResult();

        var majorVersion = listFirst(qryGetLastVersion.version[1], '.') + 1;

        var draftStatus = new Query().setDatasource(variables.datasource)
                                     .setSQL("  SELECT contentStatusId "
                                            &"    FROM #variables.tablePrefix#_contentStatus "
                                            &"ORDER BY sortOrder ASC "
                                            &"   LIMIT 1")
                                     .execute()
                                     .getResult()
                                     .contentStatusId[1];

        new Query().setDatasource(variables.datasource)
                   .setSQL("INSERT INTO #variables.tablePrefix#_contentVersion "
                          &"            ( "
                          &"              navigationId, "
                          &"              version, "
                          &"              contentStatusId, "
                          &"              content, "
                          &"              moduleId, "
                          &"              moduleAttributes, "
                          &"              linkName, "
                          &"              sesLink, "
                          &"              entityRegExp, "
                          &"              title, "
                          &"              description, "
                          &"              keywords, "
                          &"              canonical, "
                          &"              userId, "
                          &"              showContentForEntity "
                          &"            ) "
                          &"     VALUES ( "
                          &"              :navigationId, "
                          &"              :version, "
                          &"              :contentStatusId, "
                          &"              :content, "
                          &"              :moduleId, "
                          &"              :moduleAttributes, "
                          &"              :linkName, "
                          &"              :sesLink, "
                          &"              :entityRegExp, "
                          &"              :title, "
                          &"              :description, "
                          &"              :keywords, "
                          &"              :canonical, "
                          &"              :userId, "
                          &"              :showContentForEntity "
                          &"            ) ")
                   .addParam(name="navigationId",         value=arguments.navigationId,                    cfsqltype="cf_sql_numeric")
                   .addParam(name="version",              value=majorVersion,                              cfsqltype="cf_sql_float",   scale="2")
                   .addParam(name="contentStatusId",      value=draftStatus,                               cfsqltype="cf_sql_numeric")
                   .addParam(name="content",              value=qryGetLastVersion.content[1],              cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.content[1]              == '' ? true : false#")
                   .addParam(name="moduleId",             value=qryGetLastVersion.moduleId[1],             cfsqltype="cf_sql_numeric", null="#qryGetLastVersion.moduleId[1]             == '' ? true : false#")
                   .addParam(name="moduleAttributes",     value=qryGetLastVersion.moduleAttributes[1],     cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.moduleAttributes[1]     == '' ? true : false#")
                   .addParam(name="linkName",             value=qryGetLastVersion.linkName[1],             cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.linkName[1]             == '' ? true : false#")
                   .addParam(name="sesLink",              value=qryGetLastVersion.sesLink[1],              cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.sesLink[1]              == '' ? true : false#")
                   .addParam(name="entityRegExp",         value=qryGetLastVersion.entityRegExp[1],         cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.entityRegExp[1]         == '' ? true : false#")
                   .addParam(name="title",                value=qryGetLastVersion.title[1],                cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.title[1]                == '' ? true : false#")
                   .addParam(name="description",          value=qryGetLastVersion.description[1],          cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.description[1]          == '' ? true : false#")
                   .addParam(name="keywords",             value=qryGetLastVersion.keywords[1],             cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.keywords[1]             == '' ? true : false#")
                   .addParam(name="canonical",            value=qryGetLastVersion.canonical[1],            cfsqltype="cf_sql_varchar", null="#qryGetLastVersion.canonical[1]            == '' ? true : false#")
                   .addParam(name="userId",               value=arguments.userId,                          cfsqltype="cf_sql_numeric")
                   .addParam(name="showContentForEntity", value=qryGetLastVersion.showContentForEntity[1], cfsqltype="cf_sql_bit",     null="#qryGetLastVersion.showContentForEntity[1] == '' ? true : false#")
                   .execute();

        return majorVersion;
    }

    public numeric function createNewMinorVersion(required numeric navigationId, required numeric version) {
        
    }
}