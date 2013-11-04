interface {
    public userSearch function init(required cryption cryptionApi, required string tablePrefix, required string datasource);

    public array function forUser(required string userName);
}