interface {
    public irUserController function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required cryption cryptionApi);
    
    public boolean function createUser(required string userData);
    public boolean function activateUser(required userId);
    public boolean function deactivateUser(required userId);
    
    public array function getUserlist();
    
    public numeric function login(required string username, required string password);
    public boolean function logout();
}