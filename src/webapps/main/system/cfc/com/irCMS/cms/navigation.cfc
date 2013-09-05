component  implements="system.interfaces.com.irCMS.navigation" {
    public navigation function init(required string tablePrefix, required string datasource) {
        variables.tablePrefix = arguments.tablePrefix;
        variables.datasource  = arguments.datasource;
        
        return this;
    }
    
    public numeric function getMenuForSes(required string sesString) {
        return 1;
    }
    
    public boolean function editMenu(required singleUser user,required numeric menuId,required struct menuData) {
        return true;
    }
    
    public boolean function releaseMenu(required singleUser user,required numeric menuId, string version="actual") {
        return true;
    }
    
    public boolean function removeMenu(required singleUser user,required numeric menuId) {
        return true;
    }
    
    public boolean function addMenu(required singleUser user,required struct menuData, numeric menuId="0") {
        return true;
    }
    
    public boolean function revokeMenu(required singleUser user,required numeric menuId, string version="actual") {
        return true;
    }
    
    public array function getHierarchy() {
        return [];
    }
    
    public string function getUserLink(required numeric userId) {
    	if(arguments.userId != 0) {
    	   return '?ses=user&view=detail&userId='&arguments.userId;
    	}
    	else {
    	   return '';
        }
    }
}