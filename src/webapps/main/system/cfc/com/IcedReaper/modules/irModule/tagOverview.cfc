component {
    public tagOverview function init(required string datasource, required string tablePrefix) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;

        return this;
    }

    public array function filter(required numeric counter) {
        return [];
    }
}