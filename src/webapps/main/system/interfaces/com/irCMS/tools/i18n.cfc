interface {
    public i18n function init(required string tablePrefix, required string datasource, required string fallbackLanguage);
    
    public boolean function reload();
    
    public string function getTranslation(required string keyName, required string language);
}