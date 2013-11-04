component implements="system.interfaces.com.irCMS.user.userController" {
    public userController function init(required cryption cryptionApi, required validator formValidator, required string tablePrefix, required string datasource) {
        variables.cryptionApi   = arguments.cryptionApi;
        variables.formValidator = arguments.formValidator;
        variables.tablePrefix   = arguments.tablePrefix;
        variables.datasource    = arguments.datasource;
        
        return this;
    }
    
    public boolean function activateUser(required string userName) {
        return true;
    }
    
    public boolean function deactivateUser(required string userName) {
        return true;
    }
    
    public struct function createUser(required struct userData) {
        var formValidation            = {};
        formValidation.username       = isDefined("arguments.userData.username")       ? variables.formValidator.validate(content=arguments.userData.username,       ruleName='Username') : false;
        formValidation.password       = isDefined("arguments.userData.password")       ? variables.formValidator.validate(content=arguments.userData.password,       ruleName='Password') : false;
        formValidation.passwordRetype = isDefined("arguments.userData.passwordRetype") ? variables.formValidator.validate(content=arguments.userData.passwordRetype, ruleName='Password') : false;
        formValidation.gender         = isDefined("arguments.userData.gender")         ? variables.formValidator.validate(content=arguments.userData.gender,         ruleName='Gender')   : false;
        formValidation.email          = isDefined("arguments.userData.email")          ? variables.formValidator.validate(content=arguments.userData.email,          ruleName='Email')    : false;

        formValidation.passwordRetype = formValidation.password && formValidation.passwordRetype && arguments.userData.password == arguments.userData.passwordRetype;

        formValidation.username = formValidation.userNameAvailable = new Query().setDatasource(variables.datasource)
                                                                                .setSQL("SELECT userId FROM #variables.tablePrefix#_user WHERE UPPER(userName)=:userName")
                                                                                .addParam(name="userName", value=ucase(arguments.userData.username), cfsqltype="cf_sql_varchar")
                                                                                .execute()
                                                                                .getResult()
                                                                                .getRecordCount() == 0;

        if(formValidation.email) {
            formValidation.email = new Query().setDatasource(variables.datasource)
                                              .setSQL("SELECT userId FROM #variables.tablePrefix#_user WHERE UPPER(email)=:email")
                                              .addParam(name="email", value=ucase(arguments.userData.email), cfsqltype="cf_sql_varchar")
                                              .execute()
                                              .getResult()
                                              .getRecordCount() == 0;
        }

        formValidation.success = this.allSuccessfull(formValidation);

        if(formValidation.success) {
            new Query().setDatasource(variables.datasource)
                       .setSQL("INSERT INTO #variables.tablePrefix#_user "
                              &"            ( "
                              &"                userName, "
                              &"                password, "
                              &"                gender, "
                              &"                email"
                              &"            ) "
                              &"     VALUES ( "
                              &"                :userName, "
                              &"                :password, "
                              &"                :gender, "
                              &"                :email"
                              &"            ) ")
                       .addParam(name="username", value=arguments.userData.username, cfsqltype="cf_sql_varchar")
                       .addParam(name="password", value=arguments.userData.password, cfsqltype="cf_sql_varchar")
                       .addParam(name="gender",   value=arguments.userData.gender,   cfsqltype="cf_sql_varchar")
                       .addParam(name="email",    value=arguments.userData.email,    cfsqltype="cf_sql_varchar")
                       .execute();
        }

        return formValidation;
    }

    public struct function updateUser(required string userName, required struct userData) {
        var formValidation         = {};
        formValidation.email       = isDefined("arguments.userData.email")       ? variables.formValidator.validate(content=arguments.userData.email,       ruleName='Email')    : false;
        formValidation.title       = isDefined("arguments.userData.title")       ? variables.formValidator.validate(content=arguments.userData.title,       ruleName='String')   : false;
        formValidation.facebook    = isDefined("arguments.userData.facebook")    ? variables.formValidator.validate(content=arguments.userData.facebook,    ruleName='String')   : false;
        formValidation.gender      = isDefined("arguments.userData.gender")      ? variables.formValidator.validate(content=arguments.userData.gender,      ruleName='Gender')   : false;
        formValidation.github      = isDefined("arguments.userData.github")      ? variables.formValidator.validate(content=arguments.userData.github,      ruleName='String')   : false;
        formValidation.hobbies     = isDefined("arguments.userData.hobbies")     ? variables.formValidator.validate(content=arguments.userData.hobbies,     ruleName='String')   : false;
        formValidation.homepage    = isDefined("arguments.userData.homepage")    ? variables.formValidator.validate(content=arguments.userData.homepage,    ruleName='Homepage') : false;
        formValidation.twitter     = isDefined("arguments.userData.twitter")     ? variables.formValidator.validate(content=arguments.userData.twitter,     ruleName='String')   : false;
        formValidation.emailPublic = isDefined("arguments.userData.emailPublic") ? variables.formValidator.validate(content=arguments.userData.emailPublic, ruleName='Boolean')  : false;
        formValidation.themeId     = true;// TODO validate if themeId exists
        formValidation.password    = isDefined("arguments.userData.password")    ? variables.formValidator.validate(content=arguments.userData.password,    ruleName='Password') : false;
        formValidation.showBuddies = isDefined("arguments.userData.showBuddies") ? variables.formValidator.validate(content=arguments.userData.showBuddies, ruleName='Boolean')  : false;
        
        if(formValidation.email) {
            formValidation.email = new Query().setDatasource(variables.datasource)
                                              .setSQL("SELECT userId FROM #variables.tablePrefix#_user WHERE UPPER(email)=:email")
                                              .addParam(name="email", value=ucase(arguments.userData.email), cfsqltype="cf_sql_varchar")
                                              .execute()
                                              .getResult()
                                              .getRecordCount() == 0;
        }

        formValidation.success = this.allSuccessfull(formValidation);

        if(formValidation.success) {
            var passwordAddition = "";
            if(arguments.userData.password != '') {
                passwordAddition = "       password     = :password, ";
            }
            new Query().setDatasource(variables.datasource)
                       .setSQL("UPDATE #variables.tablePrefix#_user "
                              &"   SET email        = :email, "
                              &"       emailPublic  = :emailPublic, "
                              &"       themeid      = :themeid, "
                              &"       title        = :title, "
                              &"       gender       = :gender, "
                              &"       homepage     = :homepage, "
                              &"       twitterLink  = :twitterLink, "
                              &"       facebookLink = :facebookLink, "
                              &"       githubLink   = :githubLink, "
                              &"       hobbies      = :hobbies, "
                              &"       showBuddies  = :showBuddies "
                              &passwordAddition
                              &" WHERE userName     = :userName")
                       .addParam(name="email",        value=arguments.userData.email,       cfsqltype="cf_sql_varchar")
                       .addParam(name="emailPublic",  value=arguments.userData.emailPublic, cfsqltype="cf_sql_bit")
                       .addParam(name="themeid",      value=arguments.userData.themeId,     cfsqltype="cf_sql_numeric")
                       .addParam(name="password",     value=arguments.userData.password,    cfsqltype="cf_sql_varchar")
                       .addParam(name="title",        value=arguments.userData.title,       cfsqltype="cf_sql_varchar")
                       .addParam(name="gender",       value=arguments.userData.gender,      cfsqltype="cf_sql_varchar")
                       .addParam(name="homepage",     value=arguments.userData.homepage,    cfsqltype="cf_sql_varchar")
                       .addParam(name="twitterLink",  value=arguments.userData.twitter,     cfsqltype="cf_sql_varchar")
                       .addParam(name="facebookLink", value=arguments.userData.facebook,    cfsqltype="cf_sql_varchar")
                       .addParam(name="githubLink",   value=arguments.userData.github,      cfsqltype="cf_sql_varchar")
                       .addParam(name="hobbies",      value=arguments.userData.hobbies,     cfsqltype="cf_sql_varchar")
                       .addParam(name="showBuddies",  value=arguments.userData.showBuddies, cfsqltype="cf_sql_bit")
                       .addParam(name="userName",     value=arguments.userName,             cfsqltype="cf_sql_varchar")
                       .execute();
        }

        return formValidation;
    }

    private boolean function allSuccessfull(required struct structureToBeChecked) {
        for(var element in arguments.structureToBeChecked) {
            if(arguments.structureToBeChecked[element] == false) {
                return false;
            }
        }
        return true;
    }
    
    public array function getUserlist() {
        return [];
    }
    
    public boolean function login(required string username, required string password) {
    	var qGetLogin = new Query().setDatasource(variables.datasource)
                                   .setSQL("SELECT userName, active "
    	                                  &"  FROM #variables.tablePrefix#_user "
                                        &" WHERE username = :username "
                                        &"   AND password = :password"
                                          &"   AND active   = :active")
                                   .addParam(name="username", value=arguments.username,                                        cfsqltype="cf_sql_varchar")
                                   .addParam(name="password", value=variables.cryptionApi.encrypt(rawData=arguments.password), cfsqltype="cf_sql_varchar")
                                   .addParam(name="active",   value=true,                                                      cfsqltype="cf_sql_bit")
                                   .execute()
                                   .getResult();
         
         return qGetLogin.recordCount == 1;
    }
    
    public boolean function logout() {
        return true;
    }
    
    public numeric function getId(required string userName) {
        var qryUser = new Query().setDatasource(variables.datasource)
                                 .setSQL("SELECT userId "
                                        &"  FROM #variables.tablePrefix#_user "
                                        &" WHERE userName=:userName "
                                        &"   AND active=:active ")
                                 .addParam(name="userName", value=arguments.userName, cfsqltype="cf_sql_numeric")
                                 .addParam(name="active",   value=true,               cfsqltype="cf_sql_bit")
                                 .execute()
                                 .getResult();
        
        return qryUser.getRecordCount() == 1 ? qryUser.userId[1] : 0;
    }
    
    public boolean function exists(required string userName) {
        return this.getId(userName = arguments.userName) != 0;
    }
    
    public boolean function grantPermission(required string userName, required string groupName, required string roleName) {
        var oPermission = createObject("component", "system.cfc.com.IcedReaper.cms.security.permission").init(datasource   = variables.datasource
                                                                                                             ,tablePrefix  = variables.tablePrefix);
        
    	var userId  = this.getId(userName = arguments.userName);
    	var groupId = oPermission.groupGetId(groupName = arguments.groupName);
    	var roleId  = oPermission.roleGetId(roleName = arguments.roleName);
    	
    	if(userId != 0 && groupId != 0 && roleId != 0) {
          new Query().setDatasource(variables.datasource)
                     .setSQL("INSERT INTO #variables.tablePrefix#_permission"
                            &"            ( "
                            &"              userId, "
                            &"              permissionGroupId, "
                            &"              permissionRoleId "
                            &"            ) "
                            &"     VALUES ( "
                            &"              :userId, "
                            &"              :groupId, "
                            &"              :roleId "
                            &"            ) ")
                     .addParam(name="userId",  value=userId,  cfsqltype="cf_sql_numeric")
                       .addParam(name="groupId", value=groupId, cfsqltype="cf_sql_numeric")
                       .addParam(name="roleId",  value=roleId,  cfsqltype="cf_sql_numeric")
                     .execute();
            return true;
        }
        else {
            return false;
        }
    }
    
    public boolean function refusePermission(required string userName, required string groupName, required string roleName) {
        var oPermission = createObject("component", "system.cfc.com.IcedReaper.cms.security.permission").init(datasource   = variables.datasource
                                                                                                             ,tablePrefix  = variables.tablePrefix);
        
        var userId  = this.getId(userName = arguments.userName);
        var groupId = oPermission.groupGetId(groupName = arguments.groupName);
        var roleId  = oPermission.roleGetId(roleName = arguments.roleName);
        
        if(userId != 0 && groupId != 0 && roleId != 0) {
            new Query().setDatasource(variables.datasource)
                       .setSQL("DELETE FROM #variables.tablePrefix#_permission "
                              &"      WHERE userId            = :userId "
                              &"        AND permissionGroupId = :groupId "
                              &"        AND permissionRoleId  = :roleId ")
                       .addParam(name="userId",  value=userId,  cfsqltype="cf_sql_numeric")
                       .addParam(name="groupId", value=groupId, cfsqltype="cf_sql_numeric")
                       .addParam(name="roleId",  value=roleId,  cfsqltype="cf_sql_numeric")
                       .execute();
            return true;
        }
        else {
            return false;
        }
    }
}