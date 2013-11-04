interface {
    public navigation function init(required string tablePrefix, required string datasource);


    public struct function getNavigationInformation(required string sesLink, required string language);
    public navigationPoint function getActualNavigation(required struct navigationInformation);


    public boolean function addNavigation(required singleUser user, required struct navigationData, numeric navigationId=0);
    public boolean function editNavigation(required singleUser user, required numeric navigationId, required struct navigationData);
    public boolean function deleteNavigation(required singleUser user, required numeric navigationId);
    public boolean function releaseNavigation(required singleUser user, required numeric navigationId, required numeric version);
    public boolean function revokeNavigation(required singleUser user, required numeric navigationId, required numeric version);
    

    public array function getHierarchy(required string position, required string language, required numeric parentNavigationId);
    

    public string function getUserLink(required numeric userId);
}