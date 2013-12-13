component implements="system.interfaces.com.irCMS.cms.navigationPoint" {
    public navigationPoint function init(required string tablePrefix, required string datasource, required struct navigationInformation) {
    	variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
    	variables.navigationId = arguments.navigationInformation.navigationId;
        variables.sesLink      = arguments.navigationInformation.sesLink;
        variables.entities     = duplicate(arguments.navigationInformation.entityMatches);

    	return this;
    }
    
    public boolean function loadNavigation() {
	    variables.actualMenu = new Query().setDatasource(variables.datasource)
                                          .setSQL("         SELECT cv.navigationId, cv.contentVersionId, cv.moduleId, "
                                                 &"                cv.majorVersion, cv.minorVersion, cv.content, m.path, m.moduleName, cv.moduleAttributes, cv.linkname, cv.sesLink, cv.entityRegExp, "
                                                 &"                cv.title, cv.description, cv.keywords, cv.showContentForEntity, n.nameOfNavigationToShow "
                                                 &"           FROM #variables.tablePrefix#_navigation     n "
                                                 &"     INNER JOIN #variables.tablePrefix#_contentVersion cv ON n.navigationId     = cv.navigationId "
                                                 &"     INNER JOIN #variables.tablePrefix#_contentStatus  cs ON cv.contentStatusId = cs.contentStatusId "
                                                 &"LEFT OUTER JOIN #variables.tablePrefix#_module         m  ON cv.moduleId        = m.moduleId "
                                                 &"          WHERE cs.online      = :online "
                                                 &"            AND n.active       = :active "
                                                 &"            AND n.navigationId = :navigationId "
                                                 &"       ORDER BY n.sortOrder ASC")
                                          .addParam(name="navigationId", value=variables.navigationId, cfsqltype="cf_sql_numeric")
                                          .addParam(name="online",       value=true,                   cfsqltype="cf_sql_bit")
                                          .addParam(name="active",       value=true,                   cfsqltype="cf_sql_bit")
                                          .execute()
                                          .getResult();
        
        return variables.actualMenu.recordCount == 1;
    }
    
    public string function getTitle() {
        return variables.actualMenu.title[1];
    }
    
    public string function getDescription() {
        return variables.actualMenu.description[1];
    }
    
    public string function getKeywords() {
        return variables.actualMenu.keywords[1];
    }

    public array function getEntities() {
        return variables.entities;
    }
    
    public array function getBreadcrum() {
        var breadcrum = [];
        var parent    = {};
        parent.navigationId       = variables.actualMenu.navigationId[1];
        parent.parentnavigationId = variables.actualMenu.parentNvigationId[1];
        parent.linkname           = variables.actualMenu.linkName[1];
        parent.sesLink            = variables.actualMenu.sesLink[1];
        var counter = 1;
        breadcrum[counter] = parent;
        while(true) {
        	counter++;
        	if(parent.parentNavigationId != 0) {
        		breadcrum[counter] = parent;
        		parent = getParent(parent.parentnavigationId);
        	}
        	else {
        		break;
        	}
        }
        
        var finalBreadcrum = [];
        var j = 0;
        for(var i = arrayLen(breadcrum); i > 0; i--) {
        	j++;
        	finalBreadcrum[j] = breadcrum[i];
        }
        
        return finalBreadcrum;
    }
    
    private struct function getParent(required string navigationId) {
    	var parent = {};
    	parent.navigationId       = 0;
    	parent.parentnavigationId = 0;
    	parent.linkname           = "";
    	parent.sesLink            = "";
    	
        var qParent = new Query().setDatasource(variables.datasource)
                                 .setSQL("SELECT m.navigationId, m.linkname, m.sesLink, m.parentnavigationId "
                                        &"  FROM #variables.tablePrefix#_navigation AS n "
                                        &" WHERE m.navigationId=:navigationId ")
                                 .addParam(name="navigationId", value=variables.navigationId, cfsqltype="cf_sql_numeric")
                                 .execute()
                                 .getResult();
        
        if(qParent.recordCount == 0) {
            parent.navigationId       = qParent.navigationId[1];
            parent.parentNavigationId = qParent.parentNavigationId[1];
            parent.linkname           = qParent.linkname[1];
            parent.sesLink            = qParent.ses[1];
        }
    	
    	return parent;
    }

    public string function getModuleContent() {
        if(variables.actualMenu.path[1] != '') {
            var moduleContent    = "";
            var moduleAttributes = {};
            if(variables.actualMenu.moduleAttributes != '') {
                var moduleAttributes    = deserializeJSON(variables.actualMenu.moduleAttributes);
            }
            
            moduleAttributes.sesLink  = variables.sesLink;
            moduleAttributes.entities = this.getEntities();

            saveContent variable="moduleContent" {
                module template='/system/modules/'&variables.actualMenu.path[1]&'/index.cfm' attributeCollection=moduleAttributes;
            }
            return moduleContent;
        }
        else {
            throw(errorType="notFound", type=e.type, detail=e.detail);
        }
    }

    public boolean function checkShowContent() {
        return (variables.actualMenu.showContentForEntity && arrayLen(this.getEntities) > 0) || arrayLen(this.getEntities()) == 0;
    }

    public boolean function checkShowModule() {
        return (variables.actualMenu.moduleId != '');
    }
    
    public string function getContent(required string themeName, required boolean cleanArticle) {
        var content = variables.actualMenu.content[1];

        if(arguments.cleanArticle && content != '') {
            content = buildSkeleton(themeName=arguments.themeName, skeleton=content);
        }
        return content;
    }

    public string function buildSkeleton(required string themeName, required string skeleton) cachedWithin="#createTimespan(0,1,0,0)#" {
        if(isJson(arguments.skeleton)) {
            var jsonSkeleton = deserializeJSON(arguments.skeleton);
            return this.buildSubSkeleton(themeName=arguments.themeName, modules=jsonSkeleton);
        }
        else {
            return arguments.skeleton;
        }
    }

    private string function buildSubSkeleton(required string themeName, required array modules) {
        var content = "";
        saveContent variable="content" {
            for(var element = 1; element <= arguments.modules.len(); element++) {
                var moduleData = {};
                for(var moduleAttribute IN arguments.modules[element]) {
                    if(moduleAttribute != 'modules' && moduleAttribute != 'name') {
                        moduleData[moduleAttribute] = arguments.modules[element][moduleAttribute];
                    }
                }

                if(arguments.modules[element].keyExists("modules") && arguments.modules[element].modules.len() > 0) {
                    moduleData.content = this.buildSubSkeleton(themeName=arguments.themeName, modules=arguments.modules[element].modules);
                }
                
                module template="/themes/#arguments.themeName#/templates/skeleton/#arguments.modules[element].name#.cfm" attributeCollection=moduleData;
            }
        }
        return content;
    }

    public string function getTopNavigationName() {
        return variables.actualMenu.nameOfNavigationToShow[1];
    }
}