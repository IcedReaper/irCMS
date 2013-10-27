component  implements="system.interfaces.com.irCMS.security.permission" {
    import "system.interfaces.com.irCMS.*";
      
    public permission function init(required errorHandler errorHandler, required string datasource, required string tablePrefix) {
          variables.errorHandler = arguments.errorHandler;
          variables.datasource   = arguments.datasource;
          variables.tablePrefix  = arguments.tablePrefix;
          
          return this;
      }
      
      public boolean function hasPermission(required numeric userId, required string groupName, required string roleName) {
          try {
              var qCheckPermission = new Query().setDatasource(variables.datasource)
                                                .setSQL("    SELECT * "
                                                       &"      FROM #variables.tablePrefix#_permission p "
                                                       &"INNER JOIN #variables.tablePrefix#_permissionGroup pg ON p.permissionGroupId = pg.permissionGroupId "
                                                       &"INNER JOIN #variables.tablePrefix#_permissionRole  pr ON p.permissionRoleId  = pr.permissionRoleId "
                                                       &"     WHERE p.userId      = :userId "
                                                       &"       AND pg.groupName  = :groupName "
                                                       &"       AND pr.sortOrder >= (SELECT sortOrder FROM #variables.tablePrefix#_permissionRole role WHERE role.roleName = :roleName)")
                                                .addParam(name="userId",    value=arguments.userId,    cfsqltype="cf_sql_numeric")
                                                .addParam(name="groupName", value=arguments.groupName, cfsqltype="cf_sql_varchar")
                                                .addParam(name="roleName",  value=arguments.roleName,  cfsqltype="cf_sql_varchar")
                                                .execute()
                                                .getResult();
              return qCheckPermission.getRecordCount() == 1;
          }
          catch(any e) {
              variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
              return false;
          }
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