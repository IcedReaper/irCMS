component implements="system.interfaces.com.irCMS.user.userController" {
    public userController function init(required errorHandler errorHandler, required cryption cryptionApi, required validator formValidator, required string tablePrefix, required string datasource) {
    	variables.cryptionApi   = arguments.cryptionApi;
        variables.errorHandler  = arguments.errorHandler;
        variables.formValidator = arguments.formValidator;
        variables.tablePrefix   = arguments.tablePrefix;
        variables.datasource    = arguments.datasource;
        
    	return this;
    }
    
    public boolean function createUser(required string userData) {
        try {

        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            return false;
        }
    }
    
    public boolean function activateUser(required string userName) {
        try {

        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            return false;
        }
    }
    
    public boolean function deactivateUser(required string userName) {
        try {

        }
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            return false;
        }
    }

    public struct function updateUser(required string userName, required struct userData) {
        try {
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

            formValidation.success = this.allSuccessfull(formValidation);

            if(formValidation.success) {
                var passwordAddition = "";
                if(arguments.userData.password != '') {
                    passwordAddition = "       password     = :password, ";
                }
                var qUpdUser = new Query().setDatasource(variables.datasource)
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
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
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
        try {
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
        catch(any e) {
            variables.errorHandler.processError(themeName='irBootstrap', message=e.message, detail=e.detail);
            abort;
        }
    }
    
    public boolean function logout() {
        return true;
    }
}