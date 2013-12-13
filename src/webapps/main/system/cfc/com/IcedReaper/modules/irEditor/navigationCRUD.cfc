component {
    public navigationCRUD function init(required string tablePrefix, required string datasource) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        
        return this;
    }

    public array function getVersions(required numeric navigationId) {
        var versions = [];

        var qryGetVersions = new Query().setDatasource(variables.datasource)
                                        .setSQL("     SELECT cv.majorVersion, cv.minorVersion, cv.navigationId, cs.statusName "
                                               &"       FROM #variables.tablePrefix#_contentVersion cv "
                                               &" INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                               &"      WHERE cv.navigationId = :navigationId "
                                               &"   ORDER BY cv.majorVersion DESC, cv.minorVersion DESC")
                                        .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                                        .execute()
                                        .getResult();

        for(var i = 1; i <= qryGetVersions.getRecordCount(); i++) {
            versions[i] = {};
            versions[i].version      = qryGetVersions.majorVersion[i]&"."&qryGetVersions.minorVersion[i];
            versions[i].majorVersion = qryGetVersions.majorVersion[i];
            versions[i].minorVersion = qryGetVersions.minorVersion[i];
            versions[i].status       = qryGetVersions.statusName[i];
        }

        return versions;
    }

    public struct function createNewMajorVersion(required navigationCRUD coreNavigation, required numeric userId, required numeric navigationId) {
        var qryGetLastVersion = new Query().setDatasource(variables.datasource)
                                           .setSQL("  SELECT * "
                                                  &"    FROM #variables.tablePrefix#_contentVersion "
                                                  &"   WHERE navigationId = :navigationId "
                                                  &"ORDER BY majorVersion DESC "
                                                  &"   LIMIT 1")
                                           .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                                           .execute()
                                           .getResult();

        var majorVersion = qryGetLastVersion.majorVersion[1] + 1;
        
        var validation = arguments.coreNavigation.addContentVersion(navigationId = arguments.navigationId, 
                                                                    userId       = arguments.userId,
                                                                    majorVersion = majorVersion,
                                                                    minorVersion = 0,
                                                                    versionData  = {
                                                                                       contentStatusId:      arguments.coreNavigation.getDraftStatus(),
                                                                                       content:              qryGetLastVersion.content[1],
                                                                                       moduleId:             qryGetLastVersion.moduleId[1],
                                                                                       moduleAttributes:     qryGetLastVersion.moduleAttributes[1],
                                                                                       linkName:             qryGetLastVersion.linkName[1],
                                                                                       sesLink:              qryGetLastVersion.sesLink[1],
                                                                                       entityRegExp:         qryGetLastVersion.entityRegExp[1],
                                                                                       title:                qryGetLastVersion.title[1],
                                                                                       description:          qryGetLastVersion.description[1],
                                                                                       keywords:             qryGetLastVersion.keywords[1],
                                                                                       showContentForEntity: qryGetLastVersion.showContentForEntity[1] == 1,
                                                                                       permissionGroupId:    qryGetLastVersion.permissionGroupId[1],
                                                                                       permissionRoleId:     qryGetLastVersion.permissionRoleId[1]
                                                                                   });
        
        if(validation.success) {
            validation.majorVersion = majorversion;
            validation.minorVersion = 0;
        }
        return validation;
    }

    public numeric function createNewMinorVersion(required navigationCRUD coreNavigation, required numeric userId, required numeric navigationId, required numeric majorVersion) {
        var qryGetLastVersion = new Query().setDatasource(variables.datasource)
                                           .setSQL("  SELECT * "
                                                  &"    FROM #variables.tablePrefix#_contentVersion "
                                                  &"   WHERE navigationId = :navigationId "
                                                  &"     AND majorVersion = :majorVersion "
                                                  &"ORDER BY minorVersion DESC "
                                                  &"   LIMIT 1")
                                           .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                                           .addParam(name="majorVersion", value=arguments.majorVersion, cfsqltype="cf_sql_numeric")
                                           .execute()
                                           .getResult();

        var majorVersion = qryGetLastVersion.majorVersion[1];
        var minorVersion = qryGetLastVersion.minorVersion[1] + 1;

        var draftStatus = new Query().setDatasource(variables.datasource)
                                     .setSQL("  SELECT contentStatusId "
                                            &"    FROM #variables.tablePrefix#_contentStatus "
                                            &"   WHERE sortOrder = :sortOrder "
                                            &"     AND rework    = :rework "
                                            &"ORDER BY sortOrder ASC "
                                            &"   LIMIT 1")
                                     .addParam(name="sortOrder", value = 1,     cfsqltype="cf_sql_numeric")
                                     .addParam(name="rework",    value = false, cfsqltype="cf_sql_bit")
                                     .execute()
                                     .getResult()
                                     .contentStatusId[1];
        
        var contentVersionData = {
            contentStatusId:      draftStatus,
            content:              qryGetLastVersion.content[1],
            moduleId:             qryGetLastVersion.moduleId[1],
            moduleAttributes:     qryGetLastVersion.moduleAttributes[1],
            linkName:             qryGetLastVersion.linkName[1],
            sesLink:              qryGetLastVersion.sesLink[1],
            entityRegExp:         qryGetLastVersion.entityRegExp[1],
            title:                qryGetLastVersion.title[1],
            description:          qryGetLastVersion.description[1],
            keywords:             qryGetLastVersion.keywords[1],
            canonical:            qryGetLastVersion.canonical[1],
            showContentForEntity: qryGetLastVersion.showContentForEntity[1] == 1,
            permissionGroupId:    qryGetLastVersion.permissionGroupId[1],
            permissionRoleId:     qryGetLastVersion.permissionRoleId[1]
        };
        
        var validation = arguments.coreNavigation.addContentVersion(navigationId = arguments.navigationId, 
                                                                    userId       = arguments.userId,
                                                                    majorVersion = majorVersion,
                                                                    minorVersion = minorVersion,
                                                                    versionData  = contentVersionData);
        
        if(validation.success) {
            validation.majorVersion = majorversion;
            validation.minorVersion = minorVersion;
        }
        return validation;
    }

    public array function getDashboardData() {
        var dashboardData = [];

        var qGetStatus = new Query().setDatasource(variables.datasource)
                                    .setSQL("  SELECT contentStatusId, statusName, readyToRelease, online, editable "
                                           &"    FROM #variables.tablePrefix#_contentStatus "
                                           &"   WHERE showInDashboard = :showInDashboard " 
                                           &"ORDER BY sortOrder ASC, rework ASC")
                                    .addParam(name="showInDashboard", value=true, cfsqltype="cf_sql_bit")
                                    .execute()
                                    .getResult();

        for(var i = 1; i <= qGetStatus.getRecordCount(); i++) {
            dashboardData[i] = {};
            dashboardData[i].statusName     = qGetStatus.statusName[i];
            dashboardData[i].id             = qGetStatus.contentStatusId[i];
            dashboardData[i].readyToRelease = qGetStatus.readyToRelease[i];
            dashboardData[i].online         = qGetStatus.online[i];
            dashboardData[i].editable       = qGetStatus.editable[i];

            var qGetPages = new Query().setDatasource(variables.datasource)
                                       .setSQL("    SELECT cv.navigationId, cv.linkName, cv.sesLink, cv.majorVersion, cv.minorVersion, cv.creationDate, u.userName "
                                              &"      FROM #variables.tablePrefix#_contentVersion cv "
                                              &"INNER JOIN #variables.tablePrefix#_user           u  ON cv.userId = u.UserId"
                                              &"     WHERE cv.contentStatusId = :statusId "
                                              &"  ORDER BY cv.sesLink ASC, cv.majorVersion DESC, cv.minorVersion DESC")
                                       .addParam(name="statusId", value=qGetStatus.contentStatusId[i], cfsqltype="cf_sql_numeric")
                                       .execute()
                                       .getResult();

            dashboardData[i].pages = [];
            for(var j = 1; j <= qGetPages.getRecordCount(); j++) {
                dashboardData[i].pages[j] = {};
                dashboardData[i].pages[j].navigationId = qGetPages.navigationId[j];
                dashboardData[i].pages[j].pageName     = qGetPages.linkName[j];
                dashboardData[i].pages[j].sesLink      = qGetPages.sesLink[j];
                dashboardData[i].pages[j].majorVersion = qGetPages.majorVersion[j];
                dashboardData[i].pages[j].minorVersion = qGetPages.minorVersion[j];
                dashboardData[i].pages[j].lastChangeAt = dateConvert('utc2Local', qGetPages.creationDate[j]);
                dashboardData[i].pages[j].lastChangeBy = qGetPages.userName[j];
            }
        }
        
        return dashboardData;
    }
    
    public array function getCompleteSitemap(required navigationCRUD coreNavigation, required string language) {
        var qGetNavigationCategory = new Query().setDatasource(variables.datasource)
                                                .setSQL("SELECT DISTINCT position "
                                                       &"     FROM #variables.tablePrefix#_navigation "
                                                       &" ORDER BY position ASC")
                                                .execute()
                                                .getResult();
        
        var sitemap = [];
        
        for(var i = 1; i <= qGetNavigationCategory.getRowCount(); i++) {
            sitemap[i] = {
                'name': qGetNavigationCategory.position[i],
                'data': arguments.coreNavigation.getHierarchy(position=qGetNavigationCategory.position[i], language=arguments.language, parentNavigationId=0, userName=0, usePermissions=false)
            };
        }
        
        return sitemap;
    }
}