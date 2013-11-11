component implements="system.interfaces.com.irCMS.cms.navigationCRUD" {
    public navigationCRUD function init(required validator formValidator, required string tablePrefix, required string datasource) {
        variables.formValidator = arguments.formValidator;
        variables.tablePrefix   = arguments.tablePrefix;
        variables.datasource    = arguments.datasource;
        
        return this;
    }

    public struct function getNavigationInformation(required string sesLink, required string language) {
        var qGetNavigationInformation = new Query().setDatasource(variables.datasource)
                                                   .setSQL("     SELECT cv.navigationId, cv.sesLink, "
                                                          &"            regExp_matches(:sesLink, '^(' || cv.sesLink || ')/*' || cv.entityRegExp || '$') sesMatches"
                                                          &"       FROM #variables.tablePrefix#_ContentVersion cv "
                                                          &" INNER JOIN #variables.tablePrefix#_navigation     n  ON cv.navigationId=n.navigationId "
                                                          &" INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                                          &"      WHERE cs.online  = :online "
                                                          &"        AND n.active   = :active "
                                                          &"        AND n.language = :language ")
                                                   .addParam(name="sesLink",  value=arguments.sesLink,  cfsqltype="cf_sql_varchar")
                                                   .addParam(name="language", value='en', cfsqltype="cf_sql_varchar")
                                                   .addParam(name="online",   value=true,               cfsqltype="cf_sql_bit")
                                                   .addParam(name="active",   value=true,               cfsqltype="cf_sql_bit")
                                                   .execute()
                                                   .getResult();

        if(qGetNavigationInformation.recordCount == 1) {
            return {
                entityMatches: this.cleanEntityMatches(arrayMerge([], qGetNavigationInformation.sesMatches[1])),
                navigationId:  qGetNavigationInformation.navigationId[1],
                sesLink:       qGetNavigationInformation.sesLink[1]
            };
        }
        else {
            throw(type="notFound", message="Navigation was found", detail=arguments.sesLink);
        }
    }

    private array function cleanEntityMatches(required array sesMatches) {
        var cleanedMatches = duplicate(arguments.sesMatches);
        // delete the SES
        arrayDeleteAt(cleanedMatches, 1);
        
        // remove blank entries
        for(var i = arrayLen(cleanedMatches); i >= 1; i--) {
            if(cleanedMatches[i] == '') {
                arrayDeleteAt(cleanedMatches, i);
            }
        }

        // split matches into their sibblings
        var splitMatches = [];
        cleanedMatches.each(function(item) {
            splitMatches.append(listToArray(item, '/'), true);
        });
        
        return splitMatches;
    }

    public navigationPoint function getActualNavigation(required struct navigationInformation) {
        if(! isNull(arguments.navigationInformation.entityMatches) && ! isNull(arguments.navigationInformation.navigationId) && ! isNull(arguments.navigationInformation.sesLink)) {
            return new navigationPoint(variables.tablePrefix, variables.datasource, arguments.navigationInformation);
        }
        else {
            return null;
        }
    }
    
    public array function getHierarchy(required string position, required string language, required numeric parentNavigationId) cachedWithin="#createTimespan(0,0,1,0)#" {
        var hierarchy = [];

        var qGetTopLevel = new Query().setDatasource(variables.datasource)
                                      .setSQL("         SELECT cv.navigationId, cv.contentVersionId, "
                                             &"                cv.version, cv.content, m.path, m.moduleName, cv.moduleAttributes, cv.linkName, cv.sesLink, cv.entityRegExp, "
                                             &"                cv.title, cv.description, cv.keywords, cv.canonical, cv.showContentForEntity "
                                             &"           FROM #variables.tablePrefix#_navigation     n "
                                             &"     INNER JOIN #variables.tablePrefix#_contentVersion cv ON n.navigationId     = cv.navigationId "
                                             &"     INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                             &"LEFT OUTER JOIN #variables.tablePrefix#_module         m  ON cv.moduleId        = m.moduleId "
                                             &"          WHERE cs.online            = :online "
                                             &"            AND n.position           = :position "
                                             &"            AND n.language           = :language "
                                             &"            AND n.active             = :active "
                                             &"            AND n.parentNavigationId " & (arguments.parentNavigationId == 0 ? " is null " : "= :parentNavigationId ")
                                             &"       ORDER BY n.position, n.sortOrder ASC")
                                      .addParam(name="online",             value=true,                         cfsqltype="cf_sql_bit")
                                      .addParam(name="active",             value=true,                         cfsqltype="cf_sql_bit")
                                      .addParam(name="language",           value=arguments.language,           cfsqltype="cf_sql_varchar")
                                      .addParam(name="position",           value=arguments.position,           cfsqltype="cf_sql_varchar")
                                      .addParam(name="parentNavigationId", value=arguments.parentNavigationId, cfsqltype="cf_sql_numeric")
                                      .execute()
                                      .getResult();

        for(var i = 1; i <= qGetTopLevel.getRecordCount(); i++) {
            hierarchy[i] = {};
            hierarchy[i].linkname = qGetTopLevel.linkName[i];
            hierarchy[i].sesLink  = qGetTopLevel.sesLink[i];
            hierarchy[i].title    = qGetTopLevel.title[i];
            hierarchy[i].children = this.getHierarchy(position=arguments.position, language=arguments.language, parentNavigationId=qGetTopLevel.navigationId[i]);
        }

        return hierarchy;
    }
    
    /**
     * Navigation header
     **/
    public boolean function addNavigation(required struct navigationData) {
        return true;
    }

    public boolean function editNavigation(required numeric navigationId, required numeric version, required struct navigationData) {
        return true;
    }
    
    public boolean function deleteNavigation(required numeric navigationId) {
        return true;
    }
    
    /**
     *  Content Version
     **/
    public struct function addContentVersion(required numeric navigationId, required numeric userId, required numeric version, required struct versionData) {
        var formValidation = this.validateVersionData(arguments.versionData);
        
        formValidation.navigationId = isDefined("arguments.navigationId")                ? variables.formValidator.validate(content=arguments.navigationId,                ruleName='Id')      : false;
        formValidation.version      = isDefined("arguments.version")                     ? variables.formValidator.validate(content=arguments.version,                     ruleName='Version') : false;
        formValidation.status       = isDefined("arguments.versionData.contentStatusId") ? variables.formValidator.validate(content=arguments.versionData.contentStatusId, ruleName='Id')      : false; 
        
        formValidation.status       = this.statusExists(contentStatusId    = arguments.versionData.contentStatusId);
        formValidation.navigationId = this.navigationIdExists(navigationId = arguments.navigationId);
        formValidation.version      = this.versionAvailable(navigationId   = arguments.navigationId, version  = arguments.version);
        formValidation.linkName     = this.linkNameAvailable(navigationId  = arguments.navigationId, linkName = arguments.versionData.linkName);
        formValidation.sesLink      = this.sesLinkAvailable(navigationId   = arguments.navigationId, sesLink  = arguments.versionData.sesLink); 
        
        formValidation.success = this.allSuccessfull(formValidation);

        if(formValidation.success) {
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
                              &"              :userId, "
                              &"              :showContentForEntity "
                              &"            ) ")
                       .addParam(name="navigationId",         value=arguments.navigationId,                     cfsqltype="cf_sql_numeric")
                       .addParam(name="version",              value=arguments.version,                          cfsqltype="cf_sql_float",   scale="2")
                       .addParam(name="contentStatusId",      value=arguments.versionData.contentstatusId,      cfsqltype="cf_sql_numeric")
                       .addParam(name="content",              value=arguments.versionData.content,              cfsqltype="cf_sql_varchar", null="#arguments.versionData.content              == '' ? true : false#")
                       .addParam(name="moduleId",             value=arguments.versionData.moduleId,             cfsqltype="cf_sql_numeric", null="#arguments.versionData.moduleId             == '' ? true : false#")
                       .addParam(name="moduleAttributes",     value=arguments.versionData.moduleAttributes,     cfsqltype="cf_sql_varchar", null="#arguments.versionData.moduleAttributes     == '' ? true : false#")
                       .addParam(name="linkName",             value=arguments.versionData.linkName,             cfsqltype="cf_sql_varchar")
                       .addParam(name="sesLink",              value=arguments.versionData.sesLink,              cfsqltype="cf_sql_varchar")
                       .addParam(name="entityRegExp",         value=arguments.versionData.entityRegExp,         cfsqltype="cf_sql_varchar")
                       .addParam(name="title",                value=arguments.versionData.title,                cfsqltype="cf_sql_varchar", null="#arguments.versionData.title                == '' ? true : false#")
                       .addParam(name="description",          value=arguments.versionData.description,          cfsqltype="cf_sql_varchar", null="#arguments.versionData.description          == '' ? true : false#")
                       .addParam(name="keywords",             value=arguments.versionData.keywords,             cfsqltype="cf_sql_varchar", null="#arguments.versionData.keywords             == '' ? true : false#")
                       .addParam(name="userId",               value=arguments.userId,                           cfsqltype="cf_sql_numeric")
                       .addParam(name="showContentForEntity", value=arguments.versionData.showContentForEntity, cfsqltype="cf_sql_bit")
                       .execute();
        }
        
        return formValidation;
    }

    public struct function updateContentVersion(required numeric navigationId, required numeric userId, required numeric version, required struct versionData) {
        var formValidation = this.validateVersionData(arguments.versionData);
        
        formValidation.navigationId = isDefined("arguments.navigationId") ? variables.formValidator.validate(content=arguments.navigationId, ruleName='Id') : false;

        formValidation.navigationId = this.navigationIdExists(navigationId = arguments.navigationId);
        formValidation.linkName     = this.linkNameAvailable(navigationId  = arguments.navigationId, linkName = arguments.versionData.linkName);
        formValidation.sesLink      = this.sesLinkAvailable(navigationId   = arguments.navigationId, sesLink  = arguments.versionData.sesLink); 
        
        formValidation.success = this.allSuccessfull(formValidation);

        if(formValidation.success) {
            new Query().setDatasource(variables.datasource)
                       .setSQL("UPDATE #variables.tablePrefix#_contentVersion "
                              &"   SET content              = :content, "
                              &"       moduleId             = :moduleId, "
                              &"       moduleAttributes     = :moduleAttributes, "
                              &"       linkName             = :linkName, "
                              &"       sesLink              = :sesLink, "
                              &"       entityRegExp         = :entityRegExp, "
                              &"       title                = :title, "
                              &"       description          = :description, "
                              &"       keywords             = :keywords, "
                              &"       userId               = :userId, "
                              &"       showContentForEntity = :showContentForEntity "
                              &" WHERE navigationId = :navigationId "
                              &"   AND Version      = :version ")
                       .addParam(name="navigationId",         value=arguments.navigationId,                     cfsqltype="cf_sql_numeric")
                       .addParam(name="version",              value=arguments.version,                          cfsqltype="cf_sql_float",   scale="2")
                       .addParam(name="content",              value=arguments.versionData.content,              cfsqltype="cf_sql_varchar", null="#arguments.versionData.content              == '' ? true : false#")
                       .addParam(name="moduleId",             value=arguments.versionData.moduleId,             cfsqltype="cf_sql_numeric", null="#arguments.versionData.moduleId             == '' ? true : false#")
                       .addParam(name="moduleAttributes",     value=arguments.versionData.moduleAttributes,     cfsqltype="cf_sql_varchar", null="#arguments.versionData.moduleAttributes     == '' ? true : false#")
                       .addParam(name="linkName",             value=arguments.versionData.linkName,             cfsqltype="cf_sql_varchar")
                       .addParam(name="sesLink",              value=arguments.versionData.sesLink,              cfsqltype="cf_sql_varchar")
                       .addParam(name="entityRegExp",         value=arguments.versionData.entityRegExp,         cfsqltype="cf_sql_varchar")
                       .addParam(name="title",                value=arguments.versionData.title,                cfsqltype="cf_sql_varchar", null="#arguments.versionData.title                == '' ? true : false#")
                       .addParam(name="description",          value=arguments.versionData.description,          cfsqltype="cf_sql_varchar", null="#arguments.versionData.description          == '' ? true : false#")
                       .addParam(name="keywords",             value=arguments.versionData.keywords,             cfsqltype="cf_sql_varchar", null="#arguments.versionData.keywords             == '' ? true : false#")
                       .addParam(name="userId",               value=arguments.userId,                           cfsqltype="cf_sql_numeric")
                       .addParam(name="showContentForEntity", value=arguments.versionData.showContentForEntity, cfsqltype="cf_sql_bit")
                       .execute();
        }

        return formValidation;    
    }

    private struct function validateVersionData(required struct versionData) {
        var formValidation                  = {};
        formValidation.content              = isDefined("arguments.versionData.content")              ? variables.formValidator.validate(content=arguments.versionData.content,              ruleName='String')  : false;
        formValidation.linkName             = isDefined("arguments.versionData.linkName")             ? variables.formValidator.validate(content=arguments.versionData.linkName,             ruleName='String')  : false;
        formValidation.sesLink              = isDefined("arguments.versionData.sesLink")              ? variables.formValidator.validate(content=arguments.versionData.sesLink,              ruleName='SesLink') : false;
        formValidation.showContentForEntity = isDefined("arguments.versionData.showContentForEntity") ? variables.formValidator.validate(content=arguments.versionData.showContentForEntity, ruleName='Boolean') : false;
        formValidation.moduleId             = isDefined("arguments.versionData.moduleId")             ? variables.formValidator.validate(content=arguments.versionData.moduleId,             ruleName='Id',            mandatory=false) : false;
        formValidation.moduleAttributes     = isDefined("arguments.versionData.moduleAttributes")     ? variables.formValidator.validate(content=arguments.versionData.moduleAttributes,     ruleName='SimpleJson',    mandatory=false) : false;
        formValidation.entityRegExp         = isDefined("arguments.versionData.entityRegExp")         ? variables.formValidator.validate(content=arguments.versionData.entityRegExp,         ruleName='RegExpression', mandatory=false) : false;
        formValidation.title                = isDefined("arguments.versionData.title")                ? variables.formValidator.validate(content=arguments.versionData.title,                ruleName='String',        mandatory=false) : false;
        formValidation.description          = isDefined("arguments.versionData.description")          ? variables.formValidator.validate(content=arguments.versionData.description,          ruleName='String',        mandatory=false) : false;
        formValidation.keywords             = isDefined("arguments.versionData.keywords")             ? variables.formValidator.validate(content=arguments.versionData.keywords,             ruleName='String',        mandatory=false) : false;
        
        return formValidation;
    }
    
    public boolean function releaseContentVersion(required numeric navigationId, required numeric version) {
        var onlineStatusId = this.getOfflineStatusId();
        var offineStatusId = this.getOnlineStatusId();

        new Query().setDatasource(variables.datasource)
                   .setSQL("UPDATE #variables.tablePrefix#_contentVersion "
                          &"   SET contentStatusId = :offline "
                          &" WHERE navigationId    = :navigationId "
                          &"   AND contentStatusId = :online")
                   .addParam(name="offline",      value=offlineStatusId,        cfsqltype="cf_sql_numeric")
                   .addParam(name="online",       value=onlineStatusId,         cfsqltype="cf_sql_numeric")
                   .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                   .execute();

        new Query().setDatasource(variables.datasource)
                   .setSQL("UPDATE #variables.tablePrefix#_contentVersion "
                          &"   SET contentStatusId = :online "
                          &" WHERE navigationId    = :navigationId "
                          &"   AND version         = :version")
                   .addParam(name="version",      value=arguments.version,      cfsqltype="cf_sql_numeric")
                   .addParam(name="online",       value=onlineStatusId,         cfsqltype="cf_sql_numeric")
                   .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                   .execute();

        return true;
    }
    
    public boolean function revokeContentVersion(required numeric navigationId) {
        var onlineStatusId = this.getOfflineStatusId();
        var offineStatusId = this.getOnlineStatusId();

        new Query().setDatasource(variables.datasource)
                   .setSQL("UPDATE #variables.tablePrefix#_contentVersion "
                          &"   SET contentStatusId = :offline "
                          &" WHERE navigationId    = :navigationId "
                          &"   AND contentStatusId = :online")
                   .addParam(name="offline",      value=offlineStatusId,        cfsqltype="cf_sql_numeric")
                   .addParam(name="online",       value=onlineStatusId,         cfsqltype="cf_sql_numeric")
                   .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                   .execute();

        return true;
    }

    private numeric function getOfflineStatusId() {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT contentStatusId "
                                 &"  FROM #variables.tablePrefix#_contentStatus "
                                 &" WHERE online = :online "
                                 &" LIMIT 1")
                          .addParam(name="online", value=true, cfsqltype="cf_sql_bit")
                          .execute()
                          .getResult()
                          .contentStatusId[1];
    }

    private numeric function getOnlineStatusId() {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT contentStatusId "
                                 &"  FROM #variables.tablePrefix#_contentStatus "
                                 &" WHERE sortOrder > (SELECT sortOrder "
                                 &"                      FROM #variables.tablePrefix#_contentStatus "
                                 &"                     WHERE online = :online )"
                                 &" LIMIT 1")
                          .addParam(name="online", value=true, cfsqltype="cf_sql_bit")
                          .execute()
                          .getResult()
                          .contentStatusId[1];
    }
    
    /**
     * HELPER FUNCTIONS
     **/ 
    public boolean function navigationIdExists(required numeric navigationId) {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT navigationId "
                                 &"  FROM #variables.tablePrefix#_navigation "
                                 &" WHERE navigationId = :navigationId ")
                          .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                          .execute()
                          .getResult()
                          .getRecordCount() == 1;
    }
    
    public boolean function statusExists(required numeric contentStatusId) {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT contentStatusId "
                                 &"  FROM #variables.tablePrefix#_contentStatus "
                                 &" WHERE contentStatusId = :contentStatusId")
                          .addParam(name="contentStatusId", value=arguments.contentStatusId, cfsqltype="cf_sql_numeric")
                          .execute()
                          .getResult()
                          .getRecordCount() == 1;
    }
    
    public boolean function versionAvailable(required numeric navigationId, required numeric version) {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT contentVersionId "
                                 &"  FROM #variables.tablePrefix#_contentVersion "
                                 &" WHERE navigationId = :navigationId "
                                 &"   AND version      = :version ")
                          .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                          .addParam(name="version",      value=arguments.version,      cfsqltype="cf_sql_float", scale="2")
                          .execute()
                          .getResult()
                          .getRecordCount() == 0;
    }
    
    public boolean function linkNameAvailable(required numeric navigationId, required string linkName) {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("     SELECT contentVersionId "
                                 &"       FROM #variables.tablePrefix#_contentVersion cv "
                                 &" INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                 &"      WHERE navigationId <> :navigationId "
                                 &"        AND linkName     =  :linkName "
                                 &"        AND cs.online    =  :online ")
                          .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                          .addParam(name="linkName",     value=arguments.linkName,     cfsqltype="cf_sql_varchar")
                          .addParam(name="online",       value=true,                   cfsqltype="cf_sql_bit")
                          .execute()
                          .getResult()
                          .getRecordCount() == 0;
    }
    
    public boolean function sesLinkAvailable(required numeric navigationId, required string sesLink) {
        return new Query().setDatasource(variables.datasource)
                          .setSQL("     SELECT contentVersionId "
                                 &"       FROM #variables.tablePrefix#_contentVersion cv "
                                 &" INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                 &"      WHERE navigationId <> :navigationId "
                                 &"        AND sesLink      =  :sesLink "
                                 &"        AND cs.online    =  :online ")
                          .addParam(name="navigationId", value=arguments.navigationId, cfsqltype="cf_sql_numeric")
                          .addParam(name="sesLink",      value=arguments.sesLink,      cfsqltype="cf_sql_varchar")
                          .addParam(name="online",       value=true,                   cfsqltype="cf_sql_bit")
                          .execute()
                          .getResult()
                          .getRecordCount() == 0;
    }
    
    /**
     * PRIVATE FUNCTIONS
     */
    private boolean function allSuccessfull(required struct structureToBeChecked) {
        for(var element in arguments.structureToBeChecked) {
            if(arguments.structureToBeChecked[element] == false) {
                return false;
            }
        }
        return true;
    }
}