component implements="system.interfaces.com.irCMS.user" {
    public user function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required cryption cryptionApi) {
    	variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        variables.cryptionApi  = arguments.cryptionApi;
        variables.errorHandler = arguments.errorHandler;
    	
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
    
    public numeric function login(required string username, required string password) {
        try {
        	var qGetLogin = new Query().setDatasource(variables.datasource)
                                       .setSQL("SELECT userId, active "
        	                                  &"  FROM #variables.tablePrefix#_user "
        	                                  &" WHERE username=:username "
        	                                  &"   AND password=:password")
                                       .addParam(name="username", value=arguments.username,                                        cfsqltype="cf_sql_varchar")
                                       .addParam(name="password", value=variables.cryptionApi.encrypt(rawData=arguments.password), cfsqltype="cf_sql_varchar")
                                       .execute()
                                       .getResult();
             
             return qGetLoginqGetLogin.recordCount == 1 && qGetLogin.active[1] == true ? qGetLogin.userId[1] : 0;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='icedreaper_light', message=e.message, detail=e.detail);
            abort;
        }
    }
    
    public boolean function logout() {
        return true;
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