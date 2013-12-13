interface {
    public navigationPoint function init(required string  tablePrefix,required string datasource, required struct navigationInformation);
    
    public boolean function loadNavigation();
    
    public string function getTitle();
    public string function getDescription();
    public string function getKeywords();
    public string function getContent(required string themeName, required boolean cleanArticle);
    public string function buildSkeleton(required string themeName, required string skeleton);
    public array function getEntities();
    public string function getTopNavigationName();
    
    public array function getBreadcrum();
}