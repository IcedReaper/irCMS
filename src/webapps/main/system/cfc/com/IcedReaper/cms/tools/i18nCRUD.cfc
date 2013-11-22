component {
	public i18nCRUD function init(required string datasource, required string tablePrefix) {
		variables.datasource  = arguments.datasource;
		variables.tablePrefix = arguments.tablePrefix;

		return this;
	}
    
    public numeric function addKey(required string keyName) {
        return 1;
    }
    
    public boolean function addTranslation(required struct translationData) {
    	return false;
    }
}