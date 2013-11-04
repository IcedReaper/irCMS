component  implements="system.interfaces.com.irCMS.security.permission" {
    public permission function init(required string datasource, required string tablePrefix) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;
          
        return this;
    }
      
    public boolean function hasPermission(required string userName, required string groupName, required string roleName) {
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
      
    public boolean function groupAdd(required string groupName) {
        return true;
    }

    public boolean function groupRemove(required string groupName) {
        return true;
    }

    public numeric function groupGetId(required string groupName) {
        var qryGroup = new Query().setDatasource(variables.datasource)
                                  .setSQL("SELECT permissionGroupId FROM #variables.tablePrefix#_permissionGroup WHERE groupName=:groupName")
                                  .addParam(name="groupName", value=arguments.groupName, cfsqltype="cf_sql_varchar")
                                  .execute()
                                  .getResult();
        
        return qryGroup.getRecordCount() == 1 ? qryGroup.permissionGroupId[1] : 0;
    }

    public boolean function groupExists(required string groupName) {
        return true;
    }
      
    public boolean function roleAdd(required string roleName) {
        return true;
    }

    public boolean function roleRemove(required string roleName) {
        return true;
    }

    public numeric function roleGetId(required string roleName) {
        var qryRole = new Query().setDatasource(variables.datasource)
                                 .setSQL("SELECT permissionRoleId FROM #variables.tablePrefix#_permissionRole WHERE roleName=:roleName")
                                 .addParam(name="roleName", value=arguments.roleName, cfsqltype="cf_sql_varchar")
                                 .execute()
                                 .getResult();
        
        return qryRole.getRecordCount() == 1 ? qryGroup.permissionRoleId[1] : 0;
    }

    public boolean function roleExists(required string roleName) {
        return true;
    }
}