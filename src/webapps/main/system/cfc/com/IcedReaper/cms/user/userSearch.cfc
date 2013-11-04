component implements="system.interfaces.com.irCMS.user.userSearch" {
    public userSearch function init(required cryption cryptionApi, required string tablePrefix, required string datasource) {
        variables.tablePrefix  = arguments.tablePrefix;
        variables.datasource   = arguments.datasource;
        variables.cryptionApi  = arguments.cryptionApi;
        
        return this;
    }

    /*public array function getMostActiveUsers(required numeric page, required numeric userPerPage) {
        var userList = [];
    }*/

    public array function forUser(required string userName) {
        var users = [];
        var qGetUser = new Query().setDatasource(variables.datasource)
                                  .setSQL("SELECT * "
                                         &"  FROM #variables.tablePrefix#_user "
                                         &" WHERE userName LIKE :userName "
                                         &"   AND active   =    :active")
                                  .addParam(name="userName", value='%' & arguments.userName & '%', cfsqltype="cf_sql_varchar")
                                  .addParam(name="active",   value=true,                           cfsqltype="cf_sql_bit")
                                  .execute()
                                  .getResult();

        for(var i = 1; i <= qGetUser.getRecordCount(); i++) {
            users[i] = {};
            users[i].userName = qGetUser.username[i];
            users[i].avatar   = '/static/modules/irUser/'&qGetUser.avatar[i];
            users[i].title    = qGetUser.title[i];
            users[i].joinDate = dateConvert("utc2local", qGetUser.joinDate[i]);
            users[i].gender   = qGetUser.gender[i];
        }

        return users;
    }
}