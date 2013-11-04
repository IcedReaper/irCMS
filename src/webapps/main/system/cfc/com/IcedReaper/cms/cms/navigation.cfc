component implements="system.interfaces.com.irCMS.cms.navigation" {
    public navigation function init(required string tablePrefix, required string datasource) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        
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
                                                   .addParam(name="language", value=arguments.language, cfsqltype="cf_sql_varchar")
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
            throw(type="notFound", message="No navigation was found", detail=arguments.sesLink);
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
    
    public string function getUserLink(required numeric userId) {
          if(arguments.userId != 0) {
              return '/User/'&arguments.userId; // replace by userName
          }
          else {
              return '';
        }
    }
}