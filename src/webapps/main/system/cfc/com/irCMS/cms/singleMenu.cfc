component implements="system.interfaces.com.irCMS.singleMenu" {
    public singleMenu function init(required errorHandler errorHandler, required string tablePrefix
                                   ,required string datasource,         required numeric menuId
                                   ,         string version='actual') {
    	variables.errorHandler = arguments.errorHandler;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
    	variables.menuId       = arguments.menuId;
    	variables.version      = arguments.version;
    	
    	return this;
    }
    
    public boolean function load() {
    	try {
            /*var qGetMenu = new Query();
            qGetMenu.setDatasource(variables.datasource);
            qGetMenu.setSQL("SELECT m.*, c.content "
                           &"  FROM #variables.tablePrefix#_menu AS m "
                           &" INNER JOIN #variables.tablePrefix#_menuContent c ON m.menuId=c.menuId "
                           &" WHERE m.menuId=:menuId "
                           &"   AND c.version=:version");
            qGetMenu.addParam(name="menuId", value=variables.menuId, cfsqltype="cf_sql_varchar");
            qGetMenu.addParam(name="version", value=variables.version, cfsqltype="cf_sql_varchar");
            
            variables.actualMenu = qGetMenu.execute().getResult();
            
            return variables.actualMenu.recordCount == 1;*/
            
            variables.actualMenu.title[1]       = 'Titel';
            variables.actualMenu.description[1] = 'Beschreibung';
            variables.actualMenu.canonical[1]   = '';
            variables.actualMenu.keywords[1]    = 'Schlüsselwörter';
            variables.actualMenu.content[1]     = '[module template="article"]';
            
            return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='icedreaper', message=e.message, detail=e.detail);
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
    
    public array function getBreadcrum() {
        var breadcrum = [];
        var parent    = getParent(variables.menuId);
        var counter   = 0;
        while(true) {
        	counter++;
        	if(parent.menuId != 0) {
        		breadcrum[counter] = parent;
        		parent = getParent(parent.menuId);
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
    
    public array function getChildren() {
        return [];
    }
    
    public string function getContent() {
        return cleanupArticle(content=variables.actualMenu.content[1], cleanArticle=true);
    }
    
    private struct function getParent(required string menuId) {
    	var parent = {};
    	parent.menuId = 0;
    	parent.name = "";
    	parent.sesLink = "";
    	
    	return parent;
    }
    
    private string function cleanupArticle(required string content, required boolean cleanArticle) {
        if(arguments.cleanArticle) {
            // evaluate cf vars
            arguments.content = evaluate(DE(arguments.content));
            // replace all irCF Tags
            arguments.content = replaceModules(arguments.content);
        }
        return arguments.content;
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
                templateName = '/irCMS/themes/icedreaper/moduleTemplates/'&mid(arguments.content, templateStart, templateEnd-templateStart)&'.cfm';
                
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
                    module template=templateName attributes=tmpAttributeCollection;
                }
                writeOutput(trim(module));
                
                subStringStart = ++closingTag;
            }
        }
        
        return articleContent;
    }
}