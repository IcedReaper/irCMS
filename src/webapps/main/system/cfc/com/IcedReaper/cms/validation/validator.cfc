component implements="system.interfaces.com.irCMS.validation.validator" {
    public validator function init(required string tablePrefix, required string datasource) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;
        
        this.reload();
        
        return this;
    }
    
    public boolean function reload() {
    	variables.validationRules = {};
    	
    	var qryRules = new Query().setDatasource(variables.datasource)
    	                          .setSQL("  SELECT ruleName, rule, tip, description, country, language "
    	                                 &"    FROM #variables.tablePrefix#_validationRule "
    	                                 &"ORDER BY ruleName, country, language")
    	                          .execute()
    	                          .getResult();
    	
    	for(var i = 1; i <= qryRules.getRecordCount(); i++) {
    		if(! variables.validationRules.keyExists(qryRules.ruleName[i])) {
    		    variables.validationRules[ qryRules.ruleName[i] ] = {};
    	    }
    		
    		if(qryRules.country[i] != '') {
    			variables.validationRules[ qryRules.ruleName[i] ][ qryRules.country[i] ] = {};
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.country[i] ].rule        = qryRules.rule[i];
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.country[i] ].tip         = qryRules.tip[i];
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.country[i] ].description = qryRules.description[i];
    		}
    		else if(qryRules.language[i] != '') {
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.language[i] ] = {};
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.language[i] ].rule        = qryRules.rule[i];
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.language[i] ].tip         = qryRules.tip[i];
                variables.validationRules[ qryRules.ruleName[i] ][ qryRules.language[i] ].description = qryRules.description[i];
    		}
    		else {
                variables.validationRules[ qryRules.ruleName[i] ][ 'global' ] = {};
                variables.validationRules[ qryRules.ruleName[i] ][ 'global' ].rule        = qryRules.rule[i];
                variables.validationRules[ qryRules.ruleName[i] ][ 'global' ].tip         = qryRules.tip[i];
                variables.validationRules[ qryRules.ruleName[i] ][ 'global' ].description = qryRules.description[i];
    		}
    	}
    	
    	return true;
    }
    
    public boolean function validate(required string content, required string ruleName, required boolean mandatory = true, string country, string language) {
        if(arguments.mandatory && arguments.content != '') {
        	return false;
        }
        
        if(! variables.validationRules.keyExists(arguments.ruleName)) {
        	return false;
        }
        
        if(! isNull(arguments.country) && variables.validationRules[arguments.ruleName].keyExists(arguments.country)) {
            return this.doValidation(data = arguments.content, rule = variables.validationRules[arguments.ruleName][arguments.country].rule);
        }
        
        if(! isNull(arguments.language) && variables.validationRules[arguments.ruleName].keyExists(arguments.language)) {
            return this.doValidation(data = arguments.content, rule = variables.validationRules[arguments.ruleName][arguments.language].rule);
        }
        
        return this.doValidation(data = arguments.content, rule = variables.validationRules[arguments.ruleName]['global'].rule);
    }
    
    private boolean function doValidation(required any data, required string rule) {
        return (javaCast('string', arguments.data).replaceAll(arguments.rule, "").trim() == "");
    }
}