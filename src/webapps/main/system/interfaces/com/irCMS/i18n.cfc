﻿interface {
    public i18n function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required string fallbackLanguage);
    
    public boolean function reload();
    
    public numeric function addKey(required string keyName);
    public boolean function addTranslation(required struct translationData);
    
    public string function getTranslation(required string keyName, required string iso639);
}