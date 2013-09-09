interface {
    public singleMenu function init(required errorHandler errorHandler, required string tablePrefix
                                   ,required string datasource,         required numeric menuId
                                   ,         string version='actual');
    
    public boolean function load();
    
    public string function getTitle();
    public string function getDescription();
    public string function getCanonical();
    public string function getKeywords();
    public string function getContent();
    
    public array function getBreadcrum();
}