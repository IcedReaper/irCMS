interface {
    public i18nCRUD function init(required string tablePrefix, required string datasource);
    
    public numeric function addKey(required string keyName);
    public boolean function addTranslation(required struct translationData);
}