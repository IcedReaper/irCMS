component  implements="system.interfaces.com.irCMS.singleUser" {
    public singleUser function init(required errorHandler errorHandler, required string tablePrefix, required string datasource, required numeric userId) {
    	variables.errorHandler = arguments.errorHandler;
        variables.tablePrefix  = arguments.tablePrefix;
    	variables.datasource   = arguments.datasource;
    	variables.userId       = arguments.userId;
    	
    	return this;
    }
    
    public boolean function load() {
        try {
            var qGetUser = new Query();
            qGetUser.setDatasource(variables.datasource);
            qGetUser.setSQL("SELECT u.*, t.themeName, t.active as themeActive "
                           &"  FROM #variables.tablePrefix#_User u "
                           &" INNER JOIN #variables.tablePrefix#_theme t ON u.themeId = t.themeId "
                           &" WHERE u.userId=:userId");
            qGetUser.addParam(name="userId", value=variables.userId, cfsqltype="cf_sql_numeric");
            
            variables.userData = qGetUser.execute().getResult();
            
            return variables.userData.recordCount == 1;
    	}
        catch(any e) {
            variables.errorHandler.processError(themeName='icedreaper_light', message=e.message, detail=e.detail);
            abort;
        }
    }
    
    public string function getUsername() {
        return variables.userData.username[1];
    }
    
    public string function getAvatar() {
        return variables.userData.avatar[1];
    }
    
    public string function getTitle() {
        return variables.userData.title[1];
    }
    
    public string function getEmail() {
        return variables.userData.email[1];
    }
    
    public numeric function getPostCount() {
        return variables.userData.postCount[1];
    }
    
    public string function getTheme() {
    	if(variables.userData.themeActive[1] == true) {
            return variables.userData.themeName[1];
        }
        else {
        	var qGetDefaultTheme = new Query();
        	qGetDefaultTheme.setDatasource(variables.datasource);
        	qGetDefaultTheme.setSQL("SELECT themeName FROM #variables.tablePrefix#_theme WHERE defaultTheme=:default");
        	qGetDefaultTheme.addParam(name="default", value="true", cfsqltype="cf_sql_bit");
        	
        	var qryGetDefaultTheme = qGetDefaultTheme.execute().getResult();
        	
        	if(qryGetDefaultTheme.recordCount == 1) {
        		return qryGetDefaultTheme.themeName[1];
        	}
        	else {
                var qGetDefaultTheme = new Query();
                qGetDefaultTheme.setDatasource(variables.datasource);
                qGetDefaultTheme.setMaxRows(1);
                qGetDefaultTheme.setSQL("SELECT themeName FROM #variables.tablePrefix#_theme WHERE active=:default");
                qGetDefaultTheme.addParam(name="default", value="true", cfsqltype="cf_sql_bit");
                
                var qryGetDefaultTheme = qGetDefaultTheme.execute().getResult();
                
                if(qryGetDefaultTheme.recordCount == 1) {
                    return qryGetDefaultTheme.themeName[1];
                }
                else {
                    variables.errorHandler.processError(themeName='icedreaper_light', message="No Theme found!", detail="No default Theme nor any Theme found!");
                    abort;
                }
        	}
        }
    }
    
    public array function getPosts(boolean comments = false) {
        return [];
    }
    
    public boolean function hasPermission(required string permissionName) {
        return false;
    }
}