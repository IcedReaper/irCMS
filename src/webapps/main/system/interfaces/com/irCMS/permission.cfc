interface {
    public permission function init(required string tablePrefix, required string datasource, required user userApi);
    
    public boolean function hasPermission(required string permissionName, required numeric userId);
    
    public boolean function permissionIdExists();
    public boolean function permissionNameExists();
    
    public boolean function addPermission();
    public boolean function removePermission();
}