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
        	variables.userData = {};
        	variables.userData.username  = [];
        	variables.userData.avatar    = [];
        	variables.userData.title     = [];
            variables.userData.email     = [];
            variables.userData.postCount = [];
            variables.userData.theme     = [];
            
            if(variables.userId == 0) {
                variables.userData.username[1] = 'Gast';
                variables.userData.avatar[1] = '';
                variables.userData.title[1] = 'Gast';
                variables.userData.email[1] = '';
                variables.userData.postCount[1] = 0;
                variables.userData.theme[1] = 'icedreaper';
        	}
        	else if(variables.userId == 1) {
                variables.userData.username[1] = 'IcedReaper';
                variables.userData.avatar[1] = '';
                variables.userData.title[1] = 'Admin';
                variables.userData.email[1] = '';
                variables.userData.postCount[1] = 1;
                variables.userData.theme[1] = 'icedreaper';
        	}
        	return true;
        	
        	/*var qGetUser = new Query();
            qGetUser.setDatasource(variables.datasource);
            qGetUser.setSQL("SELECT * FROM #variables.tablePrefix#_User WHERE userId=:userId");
            qGetUser.addParam(name="userId", value=variables.userId, cfsqltype="cf_sql_numeric");
            
            variables.userData = qGetUser.execute().getResult();
            
            return variables.userData.recordCount == 1;*/
        }
        catch(any e) {
        	variables.errorHandler.processError(themeName='icedreaper', message=e.message, detail=e.detail);
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
        return variables.userData.theme[1];
    }
    
    public array function getPosts(boolean comments = false) {
        /*var qGetPosts = new Query();
        qGetPosts.setDatasource(variables.datasource);
        qGetPosts.setSQL("SELECT * FROM #variables.tablePrefix#_posts WHERE userId=:userId");
        qGetPosts.addParam(name="userId", value=variables.userId, cfsqltype="cf_sql_numeric");
        qGetPosts.execute();*/
        
        return [];
    }
    
    public boolean function hasPermission(required string permissionName) {
        return false;
    }
}