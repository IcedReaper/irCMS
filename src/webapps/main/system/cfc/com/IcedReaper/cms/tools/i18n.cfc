﻿component implements="system.interfaces.com.irCMS.tools.i18n" {
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
                                  .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                                  .execute()
                                  .getResult();
        
        for(var i = 1; i <= qGetKeys.getRecordCount(); i++) {
            translationReload[ qGetKeys.i18nName[i] ] = {};

            var qGetTranslation = new Query().setDatasource(variables.datasource)
                                             .setSQL("SELECT * FROM #variables.tablePrefix#_i18nTranslation WHERE i18nKeyId=:i18nKeyId")
                                             .addParam(name="i18nKeyId", value=qGetKeys.i18nKeyId[i], cfsqltype="cf_sql_numeric")
                                             .execute()
                                             .getResult();

            for(var j = 1; j <= qGetTranslation.getRecordCount(); j++) {
                translationReload[ qGetKeys.i18nName[i] ][ qGetTranslation.language[j] ] = qGetTranslation.translation[j];
            }
        }
        
        variables.translation = '';
        variables.translation = duplicate(translationReload);
        
        return true;
    }
    
    public string function getTranslation(required string keyName, required string language) {
        if(structKeyExists(variables.translation, arguments.keyName)) {
            if(structKeyExists(variables.translation[arguments.keyName], arguments.language)) {
                return variables.translation[arguments.keyName][arguments.language];
            }
            else {
                if(structKeyExists(variables.translation[arguments.keyName], variables.fallbackLanguage)) {
                    return variables.translation[arguments.keyName][variables.fallbackLanguage];
                }
                else {
                    throw(type="notFound", message="Translation key was not found", detail=arguments.keyName);
                }
            }
        }
        else {
            throw(type="notFound", message="Translation key was not found", detail=arguments.keyName);
        }
    }
}