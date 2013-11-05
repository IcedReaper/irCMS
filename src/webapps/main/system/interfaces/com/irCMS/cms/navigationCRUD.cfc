interface {
    public navigationCRUD function init(required validator formValidator, required string tablePrefix, required string datasource);

    public struct function getNavigationInformation(required string sesLink, required string language);
    public navigationPoint function getActualNavigation(required struct navigationInformation);
    
    /**
     * Navigation header
     **/
    public boolean function addNavigation(required struct navigationData);
    public boolean function editNavigation(required numeric navigationId, required numeric version, required struct navigationData);
    public boolean function deleteNavigation(required numeric navigationId);
    
    public boolean function releaseNavigation(required numeric navigationId, required numeric version);
    public boolean function revokeNavigation(required numeric navigationId, required numeric version);
    
    /**
     * Content Version
     **/
    public struct function addContentVersion(required numeric navigationId, required numeric userId, required struct versionData);
    
    /**
     * Helper Functions
     **/
    public boolean function navigationIdExists(required numeric navigationId);
    public boolean function statusExists(required numeric contentStatusId);
    public boolean function versionAlreadyInUse(required numeric navigationId, required float version);
    public boolean function linkNameAlreadyInUse(required numeric navigationId, required string linkName);
    public boolean function sesLinkAlreadyInUse(required numeric navigationId, requird string sesLink);
    
    public array function getHierarchy(required string position, required string language, required numeric parentNavigationId);
}