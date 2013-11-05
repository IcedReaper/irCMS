interface {
    public validatorCRUD function init(required string tablePrefix, required string datasource);

    public boolean function ruleExists(required string ruleName, string country, string language);
    
    public boolean function addRule(required struct ruleData);
    public boolean function removeRule(required numeric ruleName, string country, string language);
    public boolean function updateRule(required numeric oldData, required struct ruleData);
}