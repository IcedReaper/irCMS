interface {
    public permission function init(required string datasource, required string tablePrefix);
    
    public boolean function hasPermission(required string userName, required string groupName, required string roleName);
    
    // group functions
    public boolean function groupAdd(required string groupName);
    public boolean function groupRemove(required string groupName);
    public numeric function groupGetId(required string groupName);
    public boolean function groupExists(required string groupName);
    
    // role functions
    public boolean function roleAdd(required string roleName);
    public boolean function roleRemove(required string roleName);
    public numeric function roleGetId(required string roleName);
    public boolean function roleExists(required string roleName);
}