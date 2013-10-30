interface {
    public errorHandler function init(required string tablePrefix, required string datasource, required tools tools);
    
    public boolean function logError(required string message, required string detail);
    public query function getError();
    
    public void function processNotFound(required string themeName, required string type, required string detail);
    public void function processError(required string themeName, required string message, required string detail);
}