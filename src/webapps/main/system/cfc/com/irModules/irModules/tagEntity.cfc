component {
    public tagEntity function init(required errorHandler errorHandler, required string datasource, required string tablePrefix, required string tagName) {
        variables.datasource   = arguments.datasource;
        variables.tablePrefix  = arguments.tablePrefix;
        variables.tagName      = arguments.tagName;
        variables.errorHandler = arguments.errorHandler;

        return this;
    }

    
}