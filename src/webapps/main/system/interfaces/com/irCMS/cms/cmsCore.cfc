interface {
    public cmsCore function init(required string tablePrefix, required string datasource);
    
    public string function renderTemplate(required string themeName);
    
    public string function getModulePath(required string moduleName);
    public query  function getThemes();
    public string function getDefaultThemeName();
}