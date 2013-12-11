component extends="system.cfc.com.IcedReaper.cms.cms.navigationPoint" {
    public navigationVersion function init(required string tablePrefix, required string datasource, required numeric navigationId, required numeric version) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        variables.navigationId = arguments.navigationId;
        variables.version      = arguments.version;

        return this;
    }
    
    public boolean function load() {
        variables.actualMenu = new Query().setDatasource(variables.datasource)
                                          .setSQL("         SELECT n.nameOfNavigationToShow, n.active, "
                                                 &"                cv.navigationId, cv.contentVersionId, cv.moduleId, cv.version, cv.content, "
                                                 &"                cv.moduleAttributes, cv.linkname, cv.sesLink, cv.entityRegExp, cv.title, "
                                                 &"                cv.description, cv.keywords, cv.showContentForEntity, cv.versionComment, "
                                                 &"                cs.online, cs.editable, cs.readyToRelease, cs.contentStatusId, cs.statusName, "
                                                 &"                m.path, m.moduleName, cv.permissionRoleId, cv.permissionGroupId, r.roleName, g.groupName "
                                                 &"           FROM #variables.tablePrefix#_navigation      n "
                                                 &"     INNER JOIN #variables.tablePrefix#_contentVersion  cv ON n.navigationId       = cv.navigationId "
                                                 &"     INNER JOIN #variables.tablePrefix#_contentStatus   cs ON cv.contentStatusId   = cs.contentStatusId "
                                                 &"LEFT OUTER JOIN #variables.tablePrefix#_module          m  ON cv.moduleId          = m.moduleId "
                                                 &"LEFT OUTER JOIN #variables.tablePrefix#_permissionRole  r  ON cv.permissionRoleId  = r.permissionRoleId "
                                                 &"LEFT OUTER JOIN #variables.tablePrefix#_permissionGroup g  ON cv.permissionGroupId = g.permissionGroupId "
                                                 &"          WHERE cv.navigationId = :navigationId "
                                                 &"            AND cv.version      = :version"
                                                 &"       ORDER BY n.sortOrder ASC")
                                          .addParam(name="navigationId", value=variables.navigationId, cfsqltype="cf_sql_numeric")
                                          .addParam(name="version",      value=variables.version,      cfsqltype="cf_sql_float",  scale="2")
                                          .execute()
                                          .getResult();
        
        return variables.actualMenu.recordCount == 1;
    }

    public boolean function isActive() {
        return variables.actualMenu.active[1];
    }

    public boolean function isOnline() {
        return variables.actualMenu.online[1];
    }

    public boolean function isEditable() {
        return variables.actualMenu.editable[1];
    }

    public string function getSesLink() {
        return variables.actualMenu.sesLink[1];
    }

    public string function getRegExp() {
        return variables.actualMenu.entityRegExp[1];
    }
    
    public string function getLinkname() {
        return variables.actualMenu.linkname[1];
    }
    
    public string function getTopNavigationName() {
        return variables.actualMenu.nameOfNavigationToShow[1];
    }

    public string function getVersionComment() {
        return variables.actualMenu.versionComment[1];
    }

    public string function getModuleName() {
        return variables.actualMenu.moduleName[1];
    }

    public string function getModuleId() {
        return variables.actualMenu.moduleId[1];
    }

    public string function getModuleAttributes() {
        return variables.actualMenu.moduleAttributes[1];
    }

    public boolean function showContentForEntity() {
        return variables.actualMenu.showContentForEntity[1];
    }
    
    public string function getContent() {
        var content = variables.actualMenu.content[1];

        if(arguments.cleanArticle && content != '') {
            content = buildSkeleton(themeName=arguments.themeName, skeleton=content);
        }
        return content;
    }
    
    public boolean function isOffline() {
    	return new Query().setDatasource(variables.datasource)
    	                  .setSQL("SELECT contentStatusId " 
    	                         &"  FROM #variables.tablePrefix#_contentStatus "
    	                         &" WHERE contentStatusId = :contentStatusId "
    	                         &"   AND sortOrder       > (SELECT sortOrder "
    	                         &"                            FROM #variables.tablePrefix#_contentStatus "
    	                         &"                           WHERE online = :online) "
    	                         &"ORDER BY sortOrder ASC ")
    	                  .addParam(name="contentStatusId", value=variables.actualMenu.contentStatusId[1], cfsqltype="cf_sql_numeric")
                          .addParam(name="online",          value=true,                                    cfsqltype="cf_sql_bit")
    	                  .execute()
    	                  .getResult()
    	                  .getRecordCount() == 1;
    }
    
    public boolean function isReadyToRelease() {
    	return variables.actualMenu.readyToRelease[1];
    }
    
    public string function getStatusName() {
        return variables.actualMenu.statusName[1];
    }
    
    public string function getNextStatusName() {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("  SELECT statusName "
                                 &"    FROM #variables.tablePrefix#_contentStatus "
                                 &"   WHERE sortOrder > (SELECT contentStatusId "
                                 &"                        FROM #variables.tablePrefix#_contentVersion "
                                 &"                       WHERE contentVersionId = :contentVersionId) "
                                 &"ORDER BY sortOrder ASC "
                                 &"   LIMIT 1 ")
                          .addParam(name="contentVersionId", value=variables.actualMenu.contentVersionId[1], cfsqltype="cf_sql_numeric")
                          .execute()
                          .getResult()
                          .statusName[1];
    }
    
    public numeric function getPermissionGroupId() {
        return variables.actualMenu.permissionGroupId[1];
    }
    
    public numeric function getPermissionRoleId() {
        return variables.actualMenu.permissionRoleId[1];
    }
    
    public string function getPermissionGroupName() {
        return variables.actualMenu.groupName[1];
    }
    
    public string function getPermissionRoleName() {
        return variables.actualMenu.roleName[1];
    }
}