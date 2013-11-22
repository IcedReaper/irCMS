component implements="system.interfaces.com.irCMS.tools.i18n" {
    public i18n function init(required string tablePrefix, required string datasource, required string fallbackLanguage) {
    	variables.tablePrefix      = arguments.tablePrefix;
        variables.datasource       = arguments.datasource;
        variables.fallbackLanguage = arguments.fallbackLanguage;
    	variables.translation  = {};
    	
    	this.reload();
    	
    	return this;
    }
    
    public boolean function reload() {
		var translationReload = {};
    	var qGetKeys = new Query().setDatasource(variables.datasource)
                                  .setSQL("SELECT * FROM #variables.tablePrefix#_i18nKey WHERE active=:active")
                                  .addParam(name="active", value=1, cfsqltype="cf_sql_varchar")
                                  .execute()
                                  .getResult();
    	
    	for(var i = 1; i <= qGetKeys.recordCount; i++) {
    		translationReload[qGetKeys.keyName] = {};
            var qGetTranslation = new Query().setDatasource(variables.datasource)
                                             .setSQL("SELECT * FROM #variables.tablePrefix#_i18nTranslation WHERE keyName=:keyName")
                                             .addParam(name="keyName", value=qGetKeys.keyName, cfsqltype="cf_sql_varchar")
                                             .execute()
                                             .getResult();
    		translationReload[qGetKeys.keyName][qGetTranslation.iso639] = qGetTranslation.translation;
    	}
    	
    	variables.translation = '';
    	variables.translation = duplicate(translationReload);
    	
    	return true;
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