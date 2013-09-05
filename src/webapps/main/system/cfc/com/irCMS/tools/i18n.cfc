component implements="src.webapps.main.system.interfaces.com.irCMS.i18n" {
    public i18n function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required string fallbackLanguage) {
    	variables.errorHandler     = arguments.errorHandler;
        variables.tablePrefix      = arguments.tablePrefix;
        variables.datasource       = arguments.datasource;
        variables.fallbackLanguage = arguments.fallbackLanguage;
    	variables.translation  = {};
    	
    	this.reload();
    	
    	return this;
    }
    
    public boolean function reload() {
    	try {
        	var translationReload = {};
        	var qGetKeys = new Query();
        	qGetKeys.setDatasource(variables.datasource);
        	qGetKeys.setSQL("SELECT * FROM #variables.tablePrefix#_i18nKey WHERE active=:active");
        	qGetKeys.addParam(name="active", value=1, cfsqltype="cf_sql_varchar");
        	var qryKeys = qGetKeys.execute().getResult();
        	
        	for(var i = 1; i <= qryKeys.recordCount; i++) {
        		translationReload[qryKeys.keyName] = {};
        		var qGetTranslation = new Query();
        		qGetTranslation.setDatasource(variables.datasource);
        		qGetTranslation.setSQL("SELECT * FROM #variables.tablePrefix#_i18nTranslation WHERE keyName=:keyName");
        		qGetTranslation.addParam(name="keyName", value=qryKeys.keyName, cfsqltype="cf_sql_varchar");
        		var qryTranslation = qGetTranslation.execute().getResult();
        		translationReload[qryKeys.keyName][qryTranslation.iso639] = qryTranslation.translation;
        	}
        	
        	variables.translation = '';
        	variables.translation = duplicate(translationReload);
        	
        	return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='icedreaper', message=e.message, detail=e.detail);
            return false;
        }
    }
    
    public numeric function addKey(required string keyName) {
        return 1;
    }
    
    public boolean function addTranslation(required struct translationData) {
    	return false;
    }
    
    public string function getTranslation(required string keyName, required string iso639) {
        if(structKeyExists(variables.translation, arguments.keyName)) {
        	if(structKeyExists(variables.translation[arguments.keyName], arguments.iso639)) {
                return variables.translation[arguments.keyName][arguments.iso639];
        	}
        	else {
        		if(structKeyExists(variables.translation[arguments.keyName], variables.fallbackLanguage)) {
                    return variables.translation[arguments.keyName][variables.fallbackLanguage];
                }
                else {
                	return 'Translation for key #arguments.keyName# not found';
                }
        	}
        }
        else {
            return 'Translation for key #arguments.keyName# not found';
        }
    }
}