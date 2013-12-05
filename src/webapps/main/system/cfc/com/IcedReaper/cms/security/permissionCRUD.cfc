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

    public numeric function getGroupId(required string groupName) {
        var qryGroup = new Query().setDatasource(variables.datasource)
                                  .setSQL("SELECT permissionGroupId "
                                         &"  FROM #variables.tablePrefix#_permissionGroup "
                                         &" WHERE groupName = :groupName")
                                  .addParam(name="groupName", value=arguments.groupName, cfsqltype="cf_sql_varchar")
                                  .execute()
                                  .getResult();
        
        return qryGroup.getRecordCount() == 1 ? qryGroup.permissionGroupId[1] : 0;
    }

    public numeric function getRoleId(required string roleName) {
        var qryRole = new Query().setDatasource(variables.datasource)
                                 .setSQL("SELECT permissionRoleId "
                                        &"  FROM #variables.tablePrefix#_permissionRole "
                                        &" WHERE roleName = :roleName")
                                 .addParam(name="roleName", value=arguments.roleName, cfsqltype="cf_sql_varchar")
                                 .execute()
                                 .getResult();
        
        return qryRole.getRecordCount() == 1 ? qryRole.permissionRoleId[1] : 0;
    }
    
    public array function getUserWithPermission(required string groupName, required string roleName) {
    	var groupId = this.getGroupId(arguments.groupName);
    	if(groupId == 0) {
            throw(type="notFound", message="Group was not found", detail=arguments.groupName);
    	}
    	
    	var roleId  = this.getRoleId(arguments.roleName);
    	if(roleId == 0) {
            throw(type="notFound", message="Role was not found", detail=arguments.roleName);
    	}
    	
    	var qUserWithPermission = new Query().setDatasource(variables.datasource)
    	                                     .setSQL("  SELECT userId, userName "
    	                                            &"    FROM #variables.tablePrefix#_user "
    	                                            &"   WHERE userId IN (SELECT userId "
    	                                            &"                      FROM #variables.tablePrefix#_permission "
                                                    &"                     WHERE permissionRoleId  = :role "
                                                    &"                       AND permissionGroupId = :group) "
                                                    &"ORDER BY userName ASC ")
                                             .addParam(name="role",  value=roleId,   cfsqltype="cf_sql_numeric")
                                             .addParam(name="group", value=groupId, cfsqltype="cf_sql_numeric")
                                             .execute()
                                             .getResult();
    	
    	var user = [];
    	for(var i = 1; i <= qUserWithPermission.getRecordCount(); i++) {
    		user[i] = {
    			'userId':   qUserWithPermission.userId[i],
                'userName': qUserWithPermission.userName[i]
    		};
    	}
    	
    	return user;
    }
    
    public array function getUserWithoutPermission(required string groupName) {
        var groupId = this.getGroupId(arguments.groupName);
        if(groupId == 0) {
            throw(type="notFound", message="Group was not found", detail=arguments.groupName);
        }
        
        var qUserWithoutPermission = new Query().setDatasource(variables.datasource)
                                                .setSQL("  SELECT userId, userName "
                                                       &"    FROM #variables.tablePrefix#_user "
                                                       &"   WHERE active = :active "
                                                       &"     AND userId NOT IN (SELECT userId "
                                                       &"                          FROM #variables.tablePrefix#_permission "
                                                       &"                         WHERE permissionGroupId = :group) "
                                                       &"ORDER BY userName ASC ")
                                                .addParam(name="active", value=true,    cfsqltype="cf_sql_bit")
                                                .addParam(name="group",  value=groupId, cfsqltype="cf_sql_numeric")
                                                .execute()
                                                .getResult();
        
        var user = [];
        for(var i = 1; i <= qUserWithoutPermission.getRecordCount(); i++) {
            user[i] = {
                'userId':   qUserWithoutPermission.userId[i],
                'userName': qUserWithoutPermission.userName[i]
            };
        }
        
        return user;
    }
}