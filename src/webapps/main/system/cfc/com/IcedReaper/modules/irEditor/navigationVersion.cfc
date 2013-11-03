component {
    public navigationVersion function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required numeric navigationId, required numeric version) {
        variables.errorHandler = arguments.errorHandler;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        variables.navigationId = arguments.navigationId;
        variables.version      = arguments.version;

        return this;
    }
    
    public boolean function load() {
        try {
            variables.actualMenu = new Query().setDatasource(variables.datasource)
                                              .setSQL("         SELECT cv.navigationId, cv.contentVersionId, cv.moduleId, "
                                                     &"                cv.version, cv.content, m.path, m.moduleName, cv.moduleAttributes, cv.linkname, cv.sesLink, cv.entityRegExp, "
                                                     &"                cv.title, cv.description, cv.keywords, cv.canonical, cv.showContentForEntity, n.nameOfNavigationToShow, "
                                                     &"                cs.online, n.active, cv.versionComment, cs.editable "
                                                     &"           FROM #variables.tablePrefix#_navigation     n "
                                                     &"     INNER JOIN #variables.tablePrefix#_contentVersion cv ON n.navigationId     = cv.navigationId "
                                                     &"     INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                                     &"LEFT OUTER JOIN #variables.tablePrefix#_module         m  ON cv.moduleId        = m.moduleId "
                                                     &"          WHERE cv.navigationId = :navigationId "
                                                     &"            AND cv.version      = :version"
                                                     &"       ORDER BY n.sortOrder ASC")
                                              .addParam(name="navigationId", value=variables.navigationId, cfsqltype="cf_sql_numeric")
                                              .addParam(name="version",      value=variables.version,      cfsqltype="cf_sql_float",  scale="2")
                                              .execute()
                                              .getResult();
            
            return variables.actualMenu.recordCount == 1;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
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
    
    public string function getTitle() {
        return variables.actualMenu.title[1];
    }
    
    public string function getDescription() {
        return variables.actualMenu.description[1];
    }
    
    public string function getCanonical() {
        return variables.actualMenu.canonical[1];
    }
    
    public string function getKeywords() {
        return variables.actualMenu.keywords[1];
    }
    
    public string function getContent() {
        return variables.actualMenu.content[1];
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
}