interface {
    public irUser function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required string userName);
    
    public boolean function load();
    
    public string  function getUsername();
    public string  function getAvatar();
    public string  function getTitle();
    public string  function getEmail();
    public string  function isEmailPublic();
    public numeric function getPostCount();
    public string  function getTheme();
    public string  function getJoinDate();
    public string  function getgender();
    public string  function getHomepage();
    public string  function getTwitterLink();
    public string  function getFacebookLink();
    public string  function getGithubLink();
    public string  function getHobbies();
    public string  function getData(required string columnName);
    public boolean function showBuddies();
    public array   function getBuddylist();
    
    public array   function getPosts(boolean comments = false);
    
    public boolean function hasPermission(required string permissionName);
}