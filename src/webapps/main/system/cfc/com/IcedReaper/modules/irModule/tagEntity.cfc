component {
    public tagEntity function init(required string datasource, required string tablePrefix, required string tagName) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.tagName      = arguments.tagName;

        return this;
    }

    
}