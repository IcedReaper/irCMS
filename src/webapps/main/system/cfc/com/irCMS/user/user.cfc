component  implements="system.interfaces.com.irCMS.user" {
    public user function init(required string tablePrefix, required string datasource) {
    	variables.tablePrefix = arguments.tablePrefix;
        variables.datasource  = arguments.datasource;
    	
    	return this;
    }
    
    public boolean function createUser(required string userData) {
        
    }
    
    public boolean function activateUser(required userId) {
        
    }
    
    public boolean function deactivateUser(required userId) {
        
    }
    
    public array function getUserlist() {
        
    }
    
    public boolean function login(required string username, required string password) {
        
    }
    
    public boolean function logout() {
        
    }
    
    public singleUser function getUser(required numeric userId) {
    	
    }
    
    public string function getUsername(required string userId) {
        return 'IcedReaper';
    }
    
    public string function getAvatar(required string userId) {
        return '';
    }
    
    public string function getTitle(required string userId) {
        return '';
    }
    
    public string function getEmail(required string userId) {
        return '';
    }
    
    public numeric function getPostCount(required string userId) {
        return '';
    }
    
    public string function getTheme(required string userId) {
        return '';
    }
}