component implements="system.interfaces.com.irCMS.user.userController" {
    public userController function init(required errorHandler errorHandler, required cryption cryptionApi, required string tablePrefix, required string datasource) {
    	variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        variables.cryptionApi  = arguments.cryptionApi;
        variables.errorHandler = arguments.errorHandler;
    	
    	return this;
    }
    
    public boolean function createUser(required string userData) {
        
    }
    
    public boolean function activateUser(required string userName) {
        
    }
    
    public boolean function deactivateUser(required string userName) {
        
    }
    
    public array function getUserlist() {
        
    }
    
    public boolean function login(required string username, required string password) {
        try {
        	var qGetLogin = new Query().setDatasource(variables.datasource)
                                       .setSQL("SELECT userName, active "
        	                                  &"  FROM #variables.tablePrefix#_user "
        	                                  &" WHERE username = :username "
        	                                  &"   AND password = :password"
                                              &"   AND active   = :active")
                                       .addParam(name="username", value=arguments.username,                                        cfsqltype="cf_sql_varchar")
                                       .addParam(name="password", value=variables.cryptionApi.encrypt(rawData=arguments.password), cfsqltype="cf_sql_varchar")
                                       .addParam(name="active",   value=true,                                                      cfsqltype="cf_sql_bit")
                                       .execute()
                                       .getResult();
             
             return qGetLogin.recordCount == 1;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
    
    public boolean function logout() {
        return true;
    }
}