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

    public struct function createNewMajorVersion(required navigation coreNavigation, required numeric userId, required numeric navigationId) {
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
        
        var contentVersionData = {
            arguments.versionData.version:              majorVersion,
            arguments.versionData.contentStatusId:      draftStatus,
            arguments.versionData.content:              qryGetLastVersion.content[1],
            arguments.versionData.moduleId:             qryGetLastVersion.moduleId[1],
            arguments.versionData.moduleAttributes:     qryGetLastVersion.moduleAttributes[1],
            arguments.versionData.linkName:             qryGetLastVersion.linkName[1],
            arguments.versionData.sesLink:              qryGetLastVersion.sesLink[1],
            arguments.versionData.entityRegExp:         qryGetLastVersion.entityRegExp[1],
            arguments.versionData.title:                qryGetLastVersion.title[1],
            arguments.versionData.description:          qryGetLastVersion.description[1],
            arguments.versionData.keywords:             qryGetLastVersion.keywords[1],
            arguments.versionData.canonical:            qryGetLastVersion.canonical[1],
            arguments.versionData.showContentForEntity: qryGetLastVersion.showContentForEntity[1]
        };
        
        var validation = arguments.coreNavigation.addContentVersion(navigationId, userId, versionData);
        
        if(validation.success) {
            validation.majorVersion = majorversion;
        }
        else {
            validation.majorVersion = 0;
        }
        return validation;
    }

    public numeric function createNewMinorVersion(required numeric navigationId, required numeric version) {
        
    }
}