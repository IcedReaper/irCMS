interface {
    public navigationPoint function init(required errorHandler errorHandler, required string  tablePrefix,required string datasource, required struct navigationInformation);
    
    public boolean function loadNavigation();
    
    public string function getTitle();
    public string function getDescription();
    public string function getCanonical();
    public string function getKeywords();
    public string function getContent();
    public string function getEntity();
    
    public array function getBreadcrum();
}