component  implements="system.interfaces.com.irCMS.tools.validatorCRUD" {
    public validatorCRUD function init(required string tablePrefix, required string datasource) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;
        
        return this;
    }

    public boolean function ruleExists(required string ruleName, string country, string language) {
        var qryRuleExists = new Query().setDatasource(variables.datasource);
        var sql = "SELECT validationRuleId "
                & "  FROM #variables.tablePrefix#_validationRule "
                & " WHERE ruleName = :ruleName ";
        
        if(! isNull(arguments.country) && arguments.country != '') {
            sql &= " AND country  = :country "
                &  " AND language IS NULL ";
            
            qryRuleExists.addParam(name="country", value=arguments.country, cfsqltype="cf_sql_varchar");
        }
        else if(! isNull(arguments.language) && arguments.language != '') {
            sql &= " AND country  IS NULL "
                &  " AND language = :language ";
            
            qryRuleExists.addParam(name="language", value=arguments.language, cfsqltype="cf_sql_varchar");
        }
        else {
            sql &= " AND country  IS NULL "
                &  " AND language IS NULL ";
        }
        
        return qryRuleExists.setSQL(sql)
                            .addParam(name="ruleName", value=arguments.ruleName, cfsqltype="cf_sql_varchar")
                            .execute()
                            .getResult()
                            .getRecordCount() == 1;
    }
    
    public boolean function addRule(required struct ruleData) {
        var ruleOk = true;
        try {
            var pattern = createObject("java", "java.util.regex.Pattern"); 
            var matcher = pattern.compile(arguments.ruleData.rule);
        }
        catch('java.util.regex.PatternSyntaxException' regExc) {
            ruleOk = false;
        }
        
        if(ruleOk) {
            if(! this.ruleExists(ruleName=arguments.ruleData.ruleName, country=arguments.ruleData.country, language=arguments.ruleData.language)) {
                new Query().setDatasource(variables.datasource)
                           .setSQL("INSERT INTO #variables.tablePrefix#_validationRule "
                                  &"            ( "
                                  &"              ruleName, "
                                  &"              rule, "
                                  &"              country, "
                                  &"              language, "
                                  &"              tip, "
                                  &"              description, "
                                  &"            ) "
                                  &"     VALUES ( "
                                  &"              :ruleName, "
                                  &"              :rule, "
                                  &"              :country, "
                                  &"              :language, "
                                  &"              :tip, "
                                  &"              :description, "
                                  &"            ) ")
                           .addParam(name="ruleName",    value=arguments.ruleData.ruleName,    cfsqltype="cf_sql_varchar")
                           .addParam(name="rule",        value=arguments.ruleData.rule,        cfsqltype="cf_sql_varchar")
                           .addParam(name="country",     value=arguments.ruleData.country,     cfsqltype="cf_sql_varchar", null="#arguments.ruleData.country.len()     == ''#")
                           .addParam(name="language",    value=arguments.ruleData.language,    cfsqltype="cf_sql_varchar", null="#arguments.ruleData.language.len()    == ''#")
                           .addParam(name="tip",         value=arguments.ruleData.tip,         cfsqltype="cf_sql_varchar", null="#arguments.ruleData.tip.len()         == ''#")
                           .addParam(name="description", value=arguments.ruleData.description, cfsqltype="cf_sql_varchar", null="#arguments.ruleData.description.len() == ''#")
                           .execute();
                return true;
            }
        }
        
        return false;
    }

    public boolean function removeRule(required numeric ruleName, string country, string language) {
        if(this.ruleExists(ruleName=arguments.ruleData.ruleName, country=arguments.ruleData.country, language=arguments.ruleData.language)) {
            return true;
        }
        else {
            return false;
        }
    }

    public boolean function updateRule(required numeric oldData, required struct ruleData) {
        if(isNull(arguments.oldData.ruleName) || isNull(arguments.oldData.country) || isNull(arguments.language)) {
            return false;
        }
        
        var ruleOk = true;
        try {
            var pattern = createObject("java", "java.util.regex.Pattern"); 
            var matcher = pattern.compile(arguments.ruleData.rule);
        }
        catch('java.util.regex.PatternSyntaxException' regExc) {
            ruleOk = false;
        }
        
        if(ruleOk) {
            if(this.ruleExists(ruleName=arguments.oldData.ruleName, country=arguments.oldData.country, language=arguments.oldData.language)) {
                var qUpdRule = new Query().setDatasource(variables.datasource);
                sql = "UPDATE #variables.tablePrefix#_validationRule "
                    & "   SET rule = :rule, "
                    & "       country, "
                    & "       language, "
                    & "       tip, "
                    & "       description "
                    & " WHERE ruleName = :ruleName ";
                
                if(! isNull(arguments.country) && arguments.country != '') {
                    sql &= " AND country  = :whereCountry "
                        &  " AND language IS NULL ";
                    
                    qUpdRule.addParam(name="whereCountry", value=arguments.oldData.country, cfsqltype="cf_sql_varchar");
                }
                else if(! isNull(arguments.language) && arguments.language != '') {
                    sql &= " AND country  IS NULL "
                        &  " AND language = :whereLanguage ";
                    
                    qUpdRule.addParam(name="whereLanguage", value=arguments.oldData.language, cfsqltype="cf_sql_varchar");
                }
                else {
                    sql &= " AND country  IS NULL "
                        &  " AND language IS NULL ";
                }
                
                qUpdRule.setSQL(sql)
                        .addParam(name="ruleName",    value=arguments.oldData.ruleName,     cfsqltype="cf_sql_varchar")
                        .addParam(name="rule",        value=arguments.ruleData.rule,        cfsqltype="cf_sql_varchar")
                        .addParam(name="country",     value=arguments.ruleData.country,     cfsqltype="cf_sql_varchar", null="#arguments.ruleData.country.len()     == ''#")
                        .addParam(name="language",    value=arguments.ruleData.language,    cfsqltype="cf_sql_varchar", null="#arguments.ruleData.language.len()    == ''#")
                        .addParam(name="tip",         value=arguments.ruleData.tip,         cfsqltype="cf_sql_varchar", null="#arguments.ruleData.tip.len()         == ''#")
                        .addParam(name="description", value=arguments.ruleData.description, cfsqltype="cf_sql_varchar", null="#arguments.ruleData.description.len() == ''#")
                        .execute();
                return true;
            }
        }
        
        return false;
    }
}