interface {
    public validator function init(required string tablePrefix, required string datasource);
    
    public boolean function reload();
    public boolean function validate(any content, required string ruleName, required boolean mandatory = true, string country, string language);
}