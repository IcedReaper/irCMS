interface {
    public user function init(required string tablePrefix, required string datasource);
    
    public boolean function createUser(required string userData);
    public boolean function activateUser(required userId);
    public boolean function deactivateUser(required userId);
    
    public array function getUserlist();
    
    public boolean function login(required string username, required string password);
    public boolean function logout();
    
    public singleUser function getUser(required numeric userId);
    
    public string  function getUsername(required string userId);
    public string  function getAvatar(required string userId);
    public string  function getTitle(required string userId);
    public string  function getEmail(required string userId);
    public numeric function getPostCount(required string userId);
    public string  function getTheme(required string userId);
}