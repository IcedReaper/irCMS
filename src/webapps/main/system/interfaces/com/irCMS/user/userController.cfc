interface {
    public userController function init(required errorHandler errorHandler, required cryption cryptionApi, required string tablePrefix, required string datasource);
    
    public boolean function createUser(required string userData);
    public boolean function activateUser(required string userName);
    public boolean function deactivateUser(required string userName);
    
    public array function getUserlist();
    
    public boolean function login(required string username, required string password);
    public boolean function logout();
}