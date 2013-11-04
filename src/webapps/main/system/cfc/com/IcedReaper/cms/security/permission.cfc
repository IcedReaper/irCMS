component  implements="system.interfaces.com.irCMS.security.permission" {
    import "system.interfaces.com.irCMS.*";
      
    public permission function init(required errorHandler errorHandler, required string datasource, required string tablePrefix) {
        variables.errorHandler = arguments.errorHandler;
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
          
        return this;
    }
      
      public boolean function hasPermission(required string userName, required string groupName, required string roleName) {
          try {
              var qCheckPermission = new Query().setDatasource(variables.datasource)
                                                .setSQL("    SELECT * "
                                                       &"      FROM #variables.tablePrefix#_permission p "
                                                       &"INNER JOIN #variables.tablePrefix#_permissionGroup pg ON p.permissionGroupId = pg.permissionGroupId "
                                                       &"INNER JOIN #variables.tablePrefix#_permissionRole  pr ON p.permissionRoleId  = pr.permissionRoleId "
                                                       &"     WHERE p.userId      = (SELECT userId FROM #variables.tablePrefix#_user WHERE userName = :userName) "
                                                       &"       AND pg.groupName  = :groupName "
                                                       &"       AND pr.sortOrder >= (SELECT sortOrder FROM #variables.tablePrefix#_permissionRole role WHERE role.roleName = :roleName)")
                                                .addParam(name="userName",  value=arguments.userName,  cfsqltype="cf_sql_varchar")
                                                .addParam(name="groupName", value=arguments.groupName, cfsqltype="cf_sql_varchar")
                                                .addParam(name="roleName",  value=arguments.roleName,  cfsqltype="cf_sql_varchar")
                                                .execute()
                                                .getResult();
              return qCheckPermission.getRecordCount() == 1;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
      
    public boolean function groupAdd(required string groupName) {
        try {
        	return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public boolean function groupRemove(required string groupName) {
        try {
            return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public numeric function groupGetId(required string groupName) {
        try {
            var qryGroup = new Query().setDatasource(variables.datasource)
                                      .setSQL("SELECT permissionGroupId FROM #variables.tablePrefix#_permissionGroup WHERE groupName=:groupName")
                                      .addParam(name="groupName", value=arguments.groupName, cfsqltype="cf_sql_varchar")
                                      .execute()
                                      .getResult();
            
            return qryGroup.getRecordCount() == 1 ? qryGroup.permissionGroupId[1] : 0;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public boolean function groupExists(required string groupName) {
        try {
            return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
      
    public boolean function roleAdd(required string roleName) {
        try {
            return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public boolean function roleRemove(required string roleName) {
        try {
            return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public numeric function roleGetId(required string roleName) {
        try {
            var qryRole = new Query().setDatasource(variables.datasource)
                                     .setSQL("SELECT permissionRoleId FROM #variables.tablePrefix#_permissionRole WHERE roleName=:roleName")
                                     .addParam(name="roleName", value=arguments.roleName, cfsqltype="cf_sql_varchar")
                                     .execute()
                                     .getResult();
            
            return qryRole.getRecordCount() == 1 ? qryGroup.permissionRoleId[1] : 0;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }

    public boolean function roleExists(required string roleName) {
        try {
            return true;
        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
}