interface {
    public user function init(required string tablePrefix, required string datasource, required string userName);
    
    public boolean function load();
    
    public numeric function getUserId();
    public string  function getUsername();
    public string  function getAvatar();
    public string  function getTitle();
    public string  function getEmail();
    public string  function isEmailPublic();
    public numeric function getPostCount();
    public string  function getTheme();
    public string  function getJoinDate(required boolean convertToLocal = true);
    public string  function getgender();
    public string  function getHomepage();
    public string  function getTwitterLink();
    public string  function getFacebookLink();
    public string  function getGithubLink();
    public string  function getHobbies();
    public string  function getData(required string columnName);
    public boolean function showBuddies();
    public array   function getBuddylist();
    public boolean function isMyBuddy(required string userName);
    public numeric function getThemeId();
    
    public array   function getPosts(required boolean comments = false);
    
    public boolean function hasPermission(required string groupName, required string roleName);
}