component  implements="system.interfaces.com.irCMS.cmsCore" {
    public cmsCore function init(required string tablePrefix, required string datasource) {
        variables.datasource  = arguments.datasource;
        variables.tablePrefix = arguments.tablePrefix;

        return this;
    }
    
    public string function renderTemplate(required string themeName) {
        
    }

    public query function getThemes() {
        try {
            return new Query().setDatasource(variables.datasource)
                              .setSQL("SELECT themeName FROM #variables.tablePrefix#_theme WHERE active=:active")
                              .addParam(name="active", value=true, cfsqltype="cf_sql_bit")
                              .execute()
                              .getResult();
        }
        catch(any e) {
            return qFallback = queryNew('themeName', 'varchar').addRow(1)
                                                               .setCell('themeName', 'irBootstrap');
        }
    }
}