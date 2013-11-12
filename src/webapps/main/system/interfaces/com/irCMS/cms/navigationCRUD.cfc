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
    
    /**
     * Content Version
     **/
    public boolean function approveContentVersion(required numeric navigationId, required numeric version);
    public boolean function rejectContentVersion(required numeric navigationId, required numeric version);
    
    public struct function addContentVersion(required numeric navigationId, required numeric userId, required numeric version, required struct versionData);
    public struct function updateContentVersion(required numeric navigationId, required numeric userId, required numeric version, required struct versionData);
    
    public boolean function releaseContentVersion(required numeric navigationId, required numeric version);
    public boolean function revokeContentVersion(required numeric navigationId);
    
    /**
     * Helper Functions
     **/
    public boolean function navigationIdExists(required numeric navigationId);
    public boolean function statusExists(required numeric contentStatusId);
    public boolean function versionAvailable(required numeric navigationId, required numeric version);
    public boolean function linkNameAvailable(required numeric navigationId, required string linkName);
    public boolean function sesLinkAvailable(required numeric navigationId, required string sesLink);
    
    public array function getHierarchy(required string position, required string language, required numeric parentNavigationId);
}