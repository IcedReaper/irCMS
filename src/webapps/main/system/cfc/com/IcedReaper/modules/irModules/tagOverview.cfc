component {
    public tagOverview function init(required errorHandler errorHandler, required string datasource, required string tablePrefix) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.errorHandler = arguments.errorHandler;

        return this;
    }

    public array function filter(required numeric counter) {
        return [];
    }
}