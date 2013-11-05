﻿interface {
    public validator function init(required string tablePrefix, required string datasource);
    public boolean function reload();
    
    public boolean function validate(required string content, required string ruleName, required boolean mandatory, string country, string language);
    
    public boolean function ruleExists(required string rule);
    public boolean function ruleNameExists(required string ruleName);
    
    public boolean function addRule(required string rule, required string ruleName, numeric ruleId=0);
    public boolean function removeRule(required numeric ruleId);
    public boolean function updateRule(required numeric ruleId, required string newRule);
    
    public boolean function revokeRule(required numeric ruleId);
    public boolean function releaseRule(required numeric ruleId);
}