component {
    public irUserOverview function init(required string datasource, required string tablePrefix) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;

        return this;
    }

    public array function getMostActiveUsers(required numeric page, required numeric userPerPage) {
        var userList = [];
    }

    
}