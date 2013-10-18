component  implements="system.interfaces.com.irCMS.permission" {
    import "system.interfaces.com.irCMS.*";
    
	public permission function init(required string datasource,required user userApi) {
        variables.datasource = arguments.datasource;
        variables.userAPI    = arguments.userApi;
        
        return this;
    }
    
    public boolean function hasPermission(required string permissionName,required numeric userId) {
        
    }
    
    public boolean function addPermission() {
        
	}
	
	public boolean function removePermission() {
        
	}
	
	public boolean function permissionIdExists() {
        
	}
	
    public boolean function permissionNameExists() {
        
    }
}