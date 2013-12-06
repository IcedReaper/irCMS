component implements="system.interfaces.com.irCMS.user.user" {
    public user function init(required string tablePrefix, required string datasource, required string userName) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.userName     = arguments.userName;

        return this;
    }

    public boolean function load() {
        variables.userData = new Query().setDatasource(variables.datasource)
                                        .setSQL("SELECT u.*, t.themeName, t.active as themeActive "
                                               &"  FROM #variables.tablePrefix#_User u "
                                               &" INNER JOIN #variables.tablePrefix#_theme t ON u.themeId = t.themeId "
                                               &" WHERE u.userName = :userName ")
                                        .addParam(name="userName", value=variables.userName, cfsqltype="cf_sql_varchar")
                                        .execute().getResult();
        
        return variables.userData.getRecordCount() == 1;
    }
    
    public numeric function getUserId() {
        return variables.userData.userId[1];
    }
    
    public string function getUsername() {
        return variables.userData.userName[1];
    }
    
    public string function getAvatar() {
        return variables.userData.avatar[1] != '' ? '/static/modules/irUser/'&variables.userData.avatar[1] : '';
    }
    
    public string function getTitle() {
        return variables.userData.title[1];
    }
    
    public string function getEmail() {
        return variables.userData.email[1];
    }
    
    public string function isEmailPublic() {
        return variables.userData.emailPublic[1];
    }
    
    public numeric function getPostCount() {
        return variables.userData.postCount[1];
    }

    public string function getJoinDate(required boolean convertToLocal = true) {
        if(arguments.convertToLocal) {
            return dateConvert('utc2local', variables.userData.joinDate[1]);
        }
        else {
            return variables.userData.joinDate[1];
        }
    }

    public string function getGender() {
        return variables.userData.gender[1];
    }

    public string function getHomepage() {
        return variables.userData.homepage[1];
    }

    public string function getTwitterLink() {
        return variables.userData.twitterLink[1];
    }

    public string function getFacebookLink() {
        return variables.userData.facebookLink[1];
    }

    public string function getGithubLink() {
        return variables.userData.githubLink[1];
    }

    public string function getHobbies() {
        return variables.userData.hobbies[1];
    }

    public string function getData(required string columnName) {
        if(variables.userData.keyExists(arguments.columnName)) {
            return variables.userData[arguments.columnName][1];
        }
        else {
            return 'Userdata not found';
        }
    }

    public boolean function showBuddies() {
        return variables.userData.showBuddies[1];
    }

    public array function getBuddylist() {
        return [];
    }

    public boolean function isMyBuddy(required string userName) {
        if(variables.userData.userName[1] == arguments.userName) {
            return true;
        }
        else {
            return false;
        }
    }

    public numeric function getThemeId() {
        return variables.userData.themeId[1];
    }
    
    public string function getTheme() {
        if(variables.userData.themeActive[1] == true) {
            return variables.userData.themeName[1];
        }
        else {
            var qGetDefaultTheme = new Query().setDatasource(variables.datasource)
                                              .setSQL("SELECT themeName FROM #variables.tablePrefix#_theme WHERE defaultTheme=:default")
                                              .addParam(name="default", value="true", cfsqltype="cf_sql_bit")
                                              .execute()
                                              .getResult();
            
            if(qGetDefaultTheme.recordCount == 1) {
                return qGetDefaultTheme.themeName[1];
            }
            else {
                var qGetDefaultTheme = new Query().setDatasource(variables.datasource)
                                                  .setMaxRows(1)
                                                  .setSQL("SELECT themeName FROM #variables.tablePrefix#_theme WHERE active=:default")
                                                  .addParam(name="default", value="true", cfsqltype="cf_sql_bit")
                                                  .execute()
                                                  .getResult();
                
                if(qGetDefaultTheme.recordCount == 1) {
                    return qGetDefaultTheme.themeName[1];
                }
                else {
                    throw(type="notFound", message="No Theme was found", detail="");
                }
            }
        }
    }
    
    public array function getPosts(required boolean comments = false) {
        return [];
    }
    
    public boolean function hasPermission(required string groupName, required string roleName) {
        if(arguments.groupName == '' || arguments.roleName == '') {
            return false;
        }

        var oPermission = createObject("component", "system.cfc.com.IcedReaper.cms.security.permission").init(datasource   = variables.datasource
                                                                                                             ,tablePrefix  = variables.tablePrefix);

       return oPermission.hasPermission(userName=variables.userName, groupName=arguments.groupName, roleName=arguments.roleName);
    }
}