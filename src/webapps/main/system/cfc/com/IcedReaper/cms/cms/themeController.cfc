component implements="system.interfaces.com.irCMS.cms.themeController" {
    public themeController function init(required string tablePrefix, required string datasource) {
    	variables.tablePrefix  = arguments.tablePrefix;
    	variables.datasource   = arguments.datasource;
    	
    	return this;
    }

    public array function search(required string themeName) {
    	var qryThemes = new Query().setDatasource(variables.datasource)
    	                           .setSQL("SELECT * FROM #variables.tablePrefix#_theme WHERE themeName LIKE :themeName")
    	                           .addParam(name="themeName", value="%"&arguments.themeName&"%", cfsqltype="cf_sql_varchar")
    	                           .execute()
    	                           .getResult();
    	
    	var themes = [];
    	for(var i = 0; i <= qryThemes.getRecordCount(); i++) {
    		themes[i] = {};
    		themes[i].themeName    = qryThemes.themeName[i];
            themes[i].active       = qryThemes.active[i];
            themes[i].path         = qryThemes.path[i];
            themes[i].defaultTheme = qryThemes.defaultTheme[i];
            themes[i].previewPic   = '';
            themes[i].inUseBy      = new Query().setDatasource(variables.datasource)
                                                .setSQL("SELECT userId "
                                                       &"  FROM #variables.tablePrefix#_user "
                                                       &" WHERE active  = :active "
                                                       &"   AND themeId = :themeId")
                                                .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                                                .addParam(name="themeId", value=qryThemes.themeId[i], cfsqltype="cf_sql_numeric")
                                                .execute()
                                                .getResult()
                                                .getRecordCount();
    	}
    	
    	return themes;
    }
    
    public struct function createTheme(required struct themeData) {
        var formValidation          = {};
        formValidation.themeName    = isDefined("arguments.themeData.themeName")    ? variables.formValidator.validate(content=arguments.themeData.themeName,    ruleName='Themename') : false;
        formValidation.path         = isDefined("arguments.themeData.path")         ? variables.formValidator.validate(content=arguments.themeData.path,         ruleName='path')      : false;
        formValidation.active       = isDefined("arguments.themeData.active")       ? variables.formValidator.validate(content=arguments.themeData.active,       ruleName='Boolean')   : false;
        formValidation.defaultTheme = isDefined("arguments.themeData.defaultTheme") ? variables.formValidator.validate(content=arguments.themeData.defaultTheme, ruleName='Boolean')   : false;
        
        formValidation.themeName = this.themeExists(arguments.themeData.themeName);
        
        formValidation.success = this.allSuccessfull(formValidation);
        
        if(formValidation.success) {
        	if(arguments.themeData.defaultTheme == 'true') {
        		new Query().setDatasource(variables.datasource)
        		           .setSQL("UPDATE #variables.tablePrefix#_theme SET defaultTheme = :default")
        		           .addParam(name="default", value=false, cfsqltype="cf_sql_bit")
        		           .execute();
        	}
        	
        	// TODO: add unzip mechanism
        	
        	new Query().setDatasource(variables.datasource)
                       .setSQL("INSERT INTO #variables.tablePrefix#_theme "
                              &"            ( "
                              &"                themeName, "
                              &"                path, "
                              &"                active, "
                              &"                defaultTheme "
                              &"            ) "
                              &"     VALUES ( "
                              &"                :themeName, "
                              &"                :path, "
                              &"                :active, "
                              &"                :defaultTheme"
                              &"            ) ")
                       .addParam(name="themeName",    value=arguments.themeData.themeName,    cfsqltype="cf_sql_varchar")
                       .addParam(name="path",         value=arguments.themeData.path,         cfsqltype="cf_sql_varchar")
                       .addParam(name="active",       value=arguments.themeData.active,       cfsqltype="cf_sql_bit")
                       .addParam(name="defaultTheme", value=arguments.themeData.defaultTheme, cfsqltype="cf_sql_bit")
                       .execute();
        }
    }
    
    public boolean function activateTheme(required string themeName) {
        if(this.themeExists(arguments.themeData.themeName)) {
        	new Query().setDatasource(variables.datasource)
        	           .setSQL("UPDATE #variables.tablePrefix#_theme SET active=:active")
        	           .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
        	           .execute();
        }
        else {
            throw(type="notFound", message="Theme not found", detail=arguments.themeName);
        }
    }
    
    public boolean function deactivateTheme(required string themeName) {
        if(this.themeExists(arguments.themeData.themeName)) {
            new Query().setDatasource(variables.datasource)
                       .setSQL("UPDATE #variables.tablePrefix#_theme SET active=:inactive")
                       .addParam(name="inactive", value=false, cfsqltype="cf_sql_bit")
                       .execute();
        }
        else {
            throw(type="notFound", message="Theme not found", detail=arguments.themeName);
        }
    }
    
    private boolean function themeExists(required string themeName) {
	    return new Query().setDatasource(variables.datasource)
                          .setSQL("SELECT themeId "
                                 &"  FROM #variables.tablePrefix#_theme "
                                 &" WHERE themeName=:themeName")
                          .addParam(name="themeName", value=arguments.themeData.themeName, cfsqltype="cf_sql_varchar")
                          .execute()
                          .getResult()
                          .getRecordCount() == 0;
    }

    private boolean function allSuccessfull(required struct structureToBeChecked) {
        for(var element in arguments.structureToBeChecked) {
            if(arguments.structureToBeChecked[element] == false) {
                return false;
            }
        }
        return true;
    }
}