interface {
    public themeController function init(required errorHandler errorHandler, required string tablePrefix, required string datasource);

    public array function search(required string themeName);
    
    public struct function createTheme(required struct themeData);
    
    public boolean function activateTheme(required string themeName);
    public boolean function deactivateTheme(required string themeName);
}