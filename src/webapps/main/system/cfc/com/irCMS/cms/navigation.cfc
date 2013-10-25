component implements="system.interfaces.com.irCMS.navigation" {
    public navigation function init(required errorHandler errorHandler, required string tablePrefix, required string datasource) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        variables.errorHandler = arguments.errorHandler;
        
        return this;
    }

    public struct function getNavigationInformation(required string sesLink, required string language) {
        try {
            var qGetNavigationInformation = new Query().setDatasource(variables.datasource)
                                                       .setSQL("     SELECT cv.navigationId, cv.sesLink, "
                                                              &"            regExp_matches(:sesLink, '^(' || cv.sesLink || ')/*' || cv.entityRegExp || '$') sesMatches"//*/
                                                              &"       FROM #variables.tablePrefix#_ContentVersion cv"
                                                              &" INNER JOIN #variables.tablePrefix#_navigation     n  ON cv.navigationId=n.navigationId "
                                                              &"      WHERE n.language=:language ")
                                                       .addParam(name="sesLink",  value=arguments.sesLink,  cfsqltype="cf_sql_varchar")
                                                       .addParam(name="language", value=arguments.language, cfsqltype="cf_sql_varchar")
                                                       .execute()
                                                       .getResult();

            if(qGetNavigationInformation.recordCount == 1) {
                return {
                    entityMatches: this.cleanEntityMatches(arrayMerge([], qGetNavigationInformation.sesMatches[1])),
                    navigationId:  qGetNavigationInformation.navigationId[1],
                    sesLink:       qGetNavigationInformation.sesLink[1]
                };
            }
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
        return {
            entityMatches: [],
            navigationId:  0,
            sesLink:       ''
        };
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
            return new navigationPoint(variables.errorHandler, variables.tablePrefix, variables.datasource, arguments.navigationInformation);
        }
        else {
            return null;
        }
    }
    
    public boolean function addNavigation(required singleUser user, required struct navigationData, numeric navigationId=0) {
        return true;
    }

    public boolean function editNavigation(required singleUser user, required numeric navigationId, required struct navigationData) {
        return true;
    }
    
    public boolean function deleteNavigation(required singleUser user, required numeric navigationId) {
        return true;
    }
    
    public boolean function releaseNavigation(required singleUser user, required numeric navigationId, required numeric version) {
        return true;
    }
    
    public boolean function revokeNavigation(required singleUser user, required numeric navigationId, required numeric version) {
        return true;
    }
    
    public array function getHierarchy(required string position, required string language, required numeric parentNavigationId) cachedWithin="#createTimespan(0,0,1,0)#" {
        var hierarchy = [];

        var qGetTopLevel = new Query().setDatasource(variables.datasource)
                                      .setSQL("         SELECT cv.navigationId, cv.contentVersionId, "
                                             &"                cv.version, cv.content, m.path, m.moduleName, cv.moduleAttributes, cv.linkName, cv.sesLink, cv.entityRegExp, "
                                             &"                cv.title, cv.description, cv.keywords, cv.canonical, cv.showContentForEntity "
                                             &"           FROM irCMS_navigation     n "
                                             &"     INNER JOIN irCMS_contentVersion cv ON n.navigationId     = cv.navigationId "
                                             &"     INNER JOIN irCMS_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                             &"LEFT OUTER JOIN irCMS_module         m  ON cv.moduleId        = m.moduleId "
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
    
    public string function getUserLink(required numeric userId) {
          if(arguments.userId != 0) {
              return '/User/'&arguments.userId; // replace by userName
          }
          else {
              return '';
        }
    }
}