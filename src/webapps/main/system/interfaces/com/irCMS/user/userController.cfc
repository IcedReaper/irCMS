interface {
    public userController function init(required cryption cryptionApi, required validator formValidator, required string tablePrefix, required string datasource);
    
    public boolean function activateUser(required string userName);
    public boolean function deactivateUser(required string userName);

    public struct function createUser(required struct userData);
    public struct function updateUser(required string userName, required struct userData);
    
    public array function getUserlist();
    
    public boolean function login(required string username, required string password);
    public boolean function logout();
    
    public numeric function getId(required string userName);
    public boolean function exists(required string userName);
    
    public boolean function grantPermission(required string userName, required string groupName, required string roleName);
    public boolean function refusePermission(required string userName, required string groupName, required string roleName);
}