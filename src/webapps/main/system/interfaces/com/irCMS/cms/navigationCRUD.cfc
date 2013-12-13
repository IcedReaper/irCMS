interface {
    public navigationCRUD function init(required validator formValidator, required string tablePrefix, required string datasource);

    public struct function getNavigationInformation(required string sesLink, required string language, required string userName);
    public navigationPoint function getActualNavigation(required struct navigationInformation);
    
    /**
     * Navigation header
     **/
    public struct function addNavigation(required struct navigationData, required numeric userId);
    
    /**
     * Content Version
     **/
    public boolean function approveContentVersion(required numeric navigationId, required numeric majorVersion, required numeric minorVersion);
    public boolean function rejectContentVersion(required numeric navigationId, required numeric majorVersion, required numeric minorVersion);
    
    public struct function addContentVersion(required numeric navigationId, required numeric userId, required numeric majorVersion, required numeric minorVersion, required struct versionData);
    public struct function updateContentVersion(required numeric navigationId, required numeric userId, required numeric majorVersion, required numeric minorVersion, required struct versionData);
    
    public boolean function releaseContentVersion(required numeric navigationId, required numeric majorVersion, required numeric minorVersion);
    public boolean function revokeContentVersion(required numeric navigationId, required numeric majorVersion, required numeric minorVersion);
    
    public boolean function deleteContentVersion(required numeric navigationId, required numeric majorVersion, required numeric minorVersion);
    /**
     * Helper Functions
     **/
    public boolean function navigationIdExists(required numeric navigationId);
    public boolean function statusExists(required numeric contentStatusId);
    public boolean function versionAvailable(required numeric navigationId, required numeric majorVersion, required numeric minorVersion);
    public boolean function linkNameAvailable(required numeric navigationId, required string linkName);
    public boolean function sesLinkAvailable(required numeric navigationId, required string sesLink);
    
    public array function getHierarchy(required string position, required string language, required numeric parentNavigationId, required string userName);
    public numeric function getDraftStatus();
}