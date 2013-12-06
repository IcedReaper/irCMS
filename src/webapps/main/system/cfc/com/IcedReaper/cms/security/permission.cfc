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
}