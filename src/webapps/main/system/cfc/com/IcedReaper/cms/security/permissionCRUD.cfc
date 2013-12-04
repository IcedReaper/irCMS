component {
    public permissionCRUD function init(required string tablePrefix, required string datasource) {
    	variables.tablePrefix = arguments.tablePrefix;
    	variables.datasource  = arguments.datasource;
    	
    	return this;
    }
    
    public array function getRoleList() {
    	var qGetRole = new Query().setDatasource(variables.datasource)
    	                          .setSQL("  SELECT roleName "
    	                                 &"    FROM #variables.tablePrefix#_permissionRole "
    	                                 &"   WHERE active    = :active "
    	                                 &"ORDER BY sortOrder ASC")
    	                          .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
    	                          .execute()
    	                          .getResult();
    	
    	var roles = [];
    	for(var i = 1; i <= qGetRole.getRecordCount(); i++) {
    		roles[i] = qGetRole.roleName[i];
    	}
    	
    	return roles;
    }
    
    public array function getGroupList() {
    	var qGetGroup = new Query().setDatasource(variables.datasource)
    	                           .setSQL(" SELECT permissionGroupId, groupName "
    	                                  &"   FROM #variables.tablePrefix#_permissionGroup "
    	                                  &"  WHERE active = :active ")
                                   .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                                   .execute()
                                   .getResult();
        
        var groups = [];
        for(var i = 1; i <= qGetGroup.getRecordCount(); i++) {
        	groups[i] = {
        		'id':    qGetGroup.permissionGroupId[i],
        	    'name':  qGetGroup.groupName[i],
        	    'roles': []
        	};
        	var qGetRole = new Query().setDatasource(variables.datasource)
                                  .setSQL("  SELECT permissionRoleId "
                                         &"    FROM #variables.tablePrefix#_permissionRole "
                                         &"   WHERE active    = :active "
                                         &"     AND sortOrder > :guest "
                                         &"ORDER BY sortOrder ASC")
                                  .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                                  .addParam(name="guest", value=0, cfsqltype="cf_sql_numeric")
                                  .execute()
                                  .getResult();
            
        	for(var j = 1; j <= qGetRole.getRecordCount(); j++) {
        		groups[i].roles[j] = new Query().setDatasource(variables.datasource)
        		                                .setSQL("SELECT permissionId "
    		                                           &"  FROM #variables.tablePrefix#_permission "
    		                                           &" WHERE permissionRoleId  = :role "
    		                                           &"   AND permissionGroupId = :group ")
        		                                .addParam(name="role",  value=qGetRole.permissionRoleId[j],   cfsqltype="cf_sql_numeric")
                                                .addParam(name="group", value=qGetGroup.permissionGroupId[i], cfsqltype="cf_sql_numeric")
        		                                .execute()
        		                                .getResult()
        		                                .getRecordCount();
        	}
        }
        return groups;
    }
    
    public void function assignPermission(required string userName, required string roleName, required string groupName) {
    	
    }
}