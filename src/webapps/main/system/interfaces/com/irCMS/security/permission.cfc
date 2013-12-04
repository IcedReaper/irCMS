interface {
    public permission function init(required string datasource, required string tablePrefix);
    
    public boolean function hasPermission(required string userName, required string groupName, required string roleName);
}