interface {
    public validator function init(required string tablePrefix, required string datasource);
    public boolean function reload();
    
    public boolean function validate(required string content, required string ruleName, required boolean mandatory, string country, string language);
    
    public boolean function ruleExists(required string ruleName, string country, string language);
    
    public boolean function addRule(required struct ruleData);
    public boolean function removeRule(required numeric ruleName, string country, string language);
    public boolean function updateRule(required numeric ruleId, required struct ruleData);
}