interface {
    public userController function init(required errorHandler errorHandler, required cryption cryptionApi, required validator formValidator, required string tablePrefix, required string datasource);
    
    public boolean function activateUser(required string userName);
    public boolean function deactivateUser(required string userName);

    public struct function createUser(required struct userData);
    public struct function updateUser(required string userName, required struct userData);
    
    public array function getUserlist();
    
    public boolean function login(required string username, required string password);
    public boolean function logout();
}