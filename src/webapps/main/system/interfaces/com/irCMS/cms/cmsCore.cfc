interface {
    public cmsCore function init(required errorHandler errorHandler, required string tablePrefix, required string datasource);
    
    public string function renderTemplate(required string themeName);
    
    public string function getModulePath(required string moduleName);
}