interface {
    public userSearch function init(required errorHandler errorHandler, required cryption cryptionApi, required string tablePrefix, required string datasource);

    public array function forUser(required string userName);
}