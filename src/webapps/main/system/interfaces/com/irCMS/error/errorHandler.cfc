interface {
    public errorHandler function init(required string tablePrefix, required string datasource, required tools tools);
    
    public query function getError(required numeric pageNumber, required numeric errorsPerPage);
    
    public void function processNotFound(required string themeName, required struct errorStruct);
    public void function processError(required string themeName, required struct errorStruct);
}