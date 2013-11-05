﻿component  implements="system.interfaces.com.irCMS.tools.validator" {
    public validator function init(required string tablePrefix, required string datasource) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;
        
        return this;
    }
    
    public boolean function validate(required string content, required string ruleName, required boolean mandatory = true, string iso3166, string iso639,) {
        return true;
    }
    
    public boolean function ruleExists(required string rule) {
        
    }

    public boolean function ruleNameExists(required string ruleName) {
        
    }
    
    public boolean function addRule(required string rule, required string ruleName, numeric ruleId=0) {
        
    }

    public boolean function removeRule(required numeric ruleId) {
        
    }

    public boolean function updateRule(required numeric ruleId, required string newRule) {
        
    }
    
    public boolean function revokeRule(required numeric ruleId) {
        
    }

    public boolean function releaseRule(required numeric ruleId) {
        
    }
}