interface {
    public singleUser function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required numeric userId);
    
    public boolean function load();
    
    public string function getUsername();
    public string function getAvatar();
    public string function getTitle();
    public string function getEmail();
    public numeric function getPostCount();
    public string function getTheme();
    
    public array function getPosts(boolean comments = false);
    
    public boolean function hasPermission(required string permissionName);
}