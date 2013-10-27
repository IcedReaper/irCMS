component implements="system.interfaces.com.irCMS.cms.navigationPoint" {
    public navigationPoint function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required struct navigationInformation) {
    	variables.errorHandler = arguments.errorHandler;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
    	variables.navigationId = arguments.navigationInformation.navigationId;
        variables.sesLink      = arguments.navigationInformation.sesLink;
        variables.entities     = duplicate(arguments.navigationInformation.entityMatches);

    	return this;
    }
    
    public boolean function loadNavigation() {
    	try {
            variables.actualMenu = new Query().setDatasource(variables.datasource)
                                              .setSQL("         SELECT cv.navigationId, cv.contentVersionId, cv.moduleId, "
                                                     &"                cv.version, cv.content, m.path, m.moduleName, cv.moduleAttributes, cv.linkname, cv.sesLink, cv.entityRegExp, "
                                                     &"                cv.title, cv.description, cv.keywords, cv.canonical, cv.showContentForEntity, n.nameOfNavigationToShow "
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
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
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
    	
    	try {
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
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    	
    	return parent;
    }

    public string function getModuleContent() {
        if(variables.actualMenu.path[1] != '') {
            try {
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
            catch(eny e) {
                variables.errorHandler.processError(themeName='irBootstrap', message=e.message, type=e.type);
                abort;
            }
        }
        else {
            variables.errorHandler.processError(themeName='irBootstrap', message='No Module Path was found, but a module should be loaded', type='Missing Path');
            abort;
        }
    }

    public boolean function checkShowContent() {
        return (variables.actualMenu.showContentForEntity && arrayLen(this.getEntities) > 0) || arrayLen(this.getEntities()) == 0;
    }

    public boolean function checkShowModule() {
        return (variables.actualMenu.moduleId != '');
    }
    
    public string function getContent(required boolean cleanArticle) {
        var content = variables.actualMenu.content[1];

        if(arguments.cleanArticle) {
            // evaluate cf vars
            content = evaluate(DE(content));
            // replace all irCF Tags
            content = replaceModules(content);
        }
        return content;
    }
    
    private string function replaceModules(required string content) {
        var articleContent           = "";
        var subStringStart           = 1;
        var subStringEnd             = len(arguments.content);
        var templateName             = "";
        var templateStart            = 0;
        var templateEnd              = 0;
        var attributeCollection      = "";
        var tmpAttributeCollection   = {};
        var attributeCollectionStart = 0;
        var attributeCollectionEnd   = 0;
        var closingTag               = 0;
        
        saveContent variable="articleContent" {
            while(true) {
                templateStart = find('[module template="', arguments.content, subStringStart);
                if(templateStart == 0) {
                    writeOutput(mid(arguments.content, subStringStart, subStringEnd-(subStringStart-1)));
                    break;
                }
                writeOutput(mid(arguments.content, subStringStart, (templateStart-subStringStart)));
                
                templateStart += 18;
                templateEnd  = find('"', arguments.content, templateStart);
                templateName = '/system/modules/'&mid(arguments.content, templateStart, templateEnd-templateStart)&'/index.cfm';
                
                attributeCollectionStart = find('attributeCollection="', arguments.content, templateEnd);
                closingTag = find(']', arguments.content, templateEnd);
                if(attributeCollectionStart != 0 && attributeCollectionStart < closingTag) { // check if this attributeCollection is from this cfModule
                    attributeCollectionEnd = find('"', arguments.content, attributeCollectionStart+21);
                    if(attributeCollectionEnd != 0 && attributeCollectionEnd < closingTag) {
                        attributeCollection = mid(arguments.content, attributeCollectionStart+21, attributeCollectionEnd-(attributeCollectionStart+21));
                        
                        attributeCollection = listToArray(attributeCollection, ';');
                        tmpAttributeCollection = {};
                        for(var i = 1; i <= arrayLen(attributeCollection); i++) {
                            var varName = listGetAt(attributeCollection[i], 1, '=');
                            var value   = listGetAt(attributeCollection[i], 2, '=');
                            value = mid(value, 1, len(value));
                            if(left(value, 1) == '##' && right(value, 1) == '##') {
                                value = evaluate(DE(value));
                            }
                            tmpAttributeCollection[varName] = value;
                        }
                    }
                }
                saveContent variable="module" {
                    module template=templateName tmpAttributeCollection=tmpAttributeCollection;
                }
                writeOutput(trim(module));
                
                subStringStart = ++closingTag;
            }
        }
        
        return articleContent;
    }

    public string function getTopNavigationName() {
        try {
            return variables.actualMenu.nameOfNavigationToShow[1];
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message='No Module Path was found, but a module should be loaded', type='Missing Path');
            abort;
        }
    }
}