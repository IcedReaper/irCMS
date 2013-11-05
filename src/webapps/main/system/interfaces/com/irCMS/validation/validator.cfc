interface {
    public validator function init(required string tablePrefix, required string datasource);
    
    public boolean function reload();
    public boolean function validate(required string content, required string ruleName, required boolean mandatory, string country, string language);
}