interface {
    public navigation function init(required string tablePrefix, required string datasource);
    
    public query function getHierarchy(required string position);
    
    public boolean function addMenu(required singleUser user, required struct menuData, numeric menuId=0);
    public boolean function removeMenu(required singleUser user, required numeric menuId);
    public boolean function editMenu(required singleUser user, required numeric menuId, required struct menuData);
    
    public boolean function revokeMenu(required singleUser user, required numeric menuId, string version='actual');
    public boolean function releaseMenu(required singleUser user, required numeric menuId, string version='actual');
    
    public numeric function getMenuForSes(required string sesString);
    
    public string function getUserLink(required numeric userId);
}