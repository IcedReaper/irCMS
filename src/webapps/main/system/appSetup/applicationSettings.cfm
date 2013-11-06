<cfscript>
    application.tablePrefix = 'irCMS';
    application.datasource.user = 'icedreaper_user';
    application.datasource.admin = 'icedreaper_admin';
    
    application.encryption.key    = 'ircms_s3cur1ty_key_f0r_3ncrypt10n';
    application.encryption.method = 'DESEDE';
</cfscript>