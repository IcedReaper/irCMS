interface {
    public permission function init(required errorHandler errorHandler, required string datasource, required string tablePrefix);
    
    public boolean function hasPermission(required numeric userId, required string groupName, required string roleName);
    
    public boolean function permissionIdExists();
    public boolean function permissionNameExists();
    
    public boolean function addPermission();
    public boolean function removePermission();
}