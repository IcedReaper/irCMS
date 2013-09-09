component implements="system.interfaces.com.irCMS.install" {
    public install function init(required string datasource, required string tablePrefix) {
    	variables.datasource = arguments.datasource;
    	varibales.tablePrefix = arguments.tablePrefix;
    	
    	return this;
    }
    
    public boolean function theme(required string themeName) {
        try {
        	var qInstall = new Query();
        	qInstall.setDatasource(variables.datasource);
        	qInstall.setSQL("CREATE SEQUENCE seq_ircms_theme; "
                           
                           &"CREATE TABLE irCMS_theme ( "
                           &"    themeId int default nextval('seq_ircms_theme'::regclass) NOT NULL, "
                           &"    themeName TEXT NOT NULL, "
                           &"    active boolean DEFAULT true, "
                           &"    defaultTheme boolean DEFAULT false, "
                           
                           &"    CONSTRAINT 'PK_irCMS_theme_themeId' PRIMARY KEY (themeId), "
                           &"    CONSTRAINT 'UK_irCMS_theme_name' UNIQUE (themeName) "
                           &"); "
                           &"INSERT INTO irCMS_theme (themeName, defaultTheme) VALUES (:themeName, :active); ");
        	qInstall.addParam(name="themeName", value=arguments.themeName, cfsqltype="cf_sql_varchar");
            qInstall.addParam(name="active", value=true, cfsqltype="cf_sql_bit");
        	qInstall.execute();
            return false;
        }
        catch(any e) {
            return false;
        }
    }
    
    public boolean function user(required string userName, required string userEmail) {
        try {
            var qInstall = new Query();
            qInstall.setDatasource(variables.datasource);
            qInstall.setSQL("CREATE SEQUENCE seq_ircms_user; "
                           
                           &"CREATE TABLE ircms_user ( "
                           &"    userid integer NOT NULL DEFAULT nextval('seq_ircms_user'::regclass), "
                           &"    username text NOT NULL, "
                           &"    email text NOT NULL, "
                           &"    avatar text, "
                           &"    active boolean DEFAULT true, "
                           &"    themeid integer DEFAULT 1, "
                           &"    postcount integer DEFAULT 0, "
                           
                           &"    CONSTRAINT 'PK_irCMS_user_userId' PRIMARY KEY (userid), "
                           &"    CONSTRAINT 'FK_irCMS_user_themeId' FOREIGN KEY (themeid) REFERENCES ircms_theme (themeid) ON UPDATE NO ACTION ON DELETE NO ACTION, "
                           &"    CONSTRAINT 'UK_irCMS_user_username' UNIQUE (username) "
                           &") "
                           &"WITH ( "
                           &"    OIDS=FALSE "
                           &"); "
                           &"CREATE INDEX 'FKI_irCMS_user_themeId' ON ircms_user USING btree (themeid); "
                           
                           &"INSERT INTO irCMS_user (userName, email, themeId) VALUES (:defaultUserName, :defaultUserEmail, 1);");
            qInstall.addParam(name="defaultUserName",  value=arguments.userName,  cfsqltype="cf_sql_varchar");
            qInstall.addParam(name="defaultUserEmail", value=arguments.userEmail, cfsqltype="cf_sql_varchar");
            qInstall.execute();
            return false;
        }
        catch(any e) {
            return false;
        }
    }
    
    public boolean function error() {
        try {
            var qInstall = new Query();
            qInstall.setDatasource(variables.datasource);
            qInstall.setSQL("CREATE SEQUENCE seq_ircms_error; "
                           
                           &"CREATE TABLE irCMS_error( "
                           &"    errorId int default nextval('seq_ircms_error'::regclass) NOT NULL, "
                           &"    message TEXT NOT NULL, "
                           &"    detail TEXT NOT NULL, "
                           &"    recDate timestamp with time zone, "
                            
                           &"    CONSTRAINT 'PK_irCMS_error_errorId' PRIMARY KEY (errorId) "
                           &");");
            qInstall.execute();
            return false;
        }
        catch(any e) {
            return false;
        }
    }
    
    public boolean function menu() {
        try {
            var qInstall = new Query();
            qInstall.setDatasource(variables.datasource);
            qInstall.setSQL("CREATE SEQUENCE seq_ircms_menu; "
                           
                           &"CREATE TABLE ircms_menu ( "
                           &"    menuid integer NOT NULL DEFAULT nextval('seq_ircms_menu'::regclass), "
                           &"    parentmenuid integer, "
                           &"    linkname text NOT NULL, "
                           &"    ses text NOT NULL, "
                           &"    recnew timestamp with time zone DEFAULT now(), "
                           &"    active boolean DEFAULT false, "
                           &"    title text NOT NULL, "
                           &"    description text NOT NULL, "
                           &"    canonical text, "
                           &"    keywords text NOT NULL, "
                           
                           &"    CONSTRAINT 'PK_irCMS_menu_menuId' PRIMARY KEY (menuid), "
                           &"    CONSTRAINT 'UK_irCMS_menu_ses' UNIQUE (ses) "
                           &") "
                           &"WITH ( "
                           &"    OIDS=FALSE "
                           &"); "
                           &"CREATE INDEX 'IDX_irCMS_menu_activeLinks' ON ircms_menu USING btree (active, parentmenuid); "
                           &"CREATE INDEX 'IDX_irCMS_menu_parentMenuId' ON ircms_menu USING btree (parentmenuid); "
                           &"CREATE INDEX 'IDX_irCMS_menu_ses' ON ircms_menu USING btree (ses); "
                            
                           &"CREATE SEQUENCE seq_ircms_menucontent; "
                            
                           &"CREATE TABLE ircms_menucontent ( "
                           &"    menucontentid integer NOT NULL DEFAULT nextval('seq_ircms_menucontent'::regclass), "
                           &"    menuid integer NOT NULL, "
                           &"    content text NOT NULL, "
                           &"    version text NOT NULL DEFAULT 'actual'::text, "
                           &"    active boolean DEFAULT false, "
                           &"    userid integer NOT NULL, "
                           &"    recnew timestamp with time zone DEFAULT now(), "
                           &"    releasedate timestamp with time zone, "
                           
                           &"    CONSTRAINT 'PK_irCMS_menuContent_menuContentId' PRIMARY KEY (menucontentid), "
                           &"    CONSTRAINT 'FK_irCMS_menuContent_menuId' FOREIGN KEY (menuid) REFERENCES ircms_menu (menuid) ON UPDATE NO ACTION ON DELETE NO ACTION "
                           &") "
                           &"WITH ( "
                           &"    OIDS=FALSE "
                           &"); "
                            
                           &" CREATE INDEX 'FKI_irCMS_menuContent_menuId' ON ircms_menucontent USING btree (menuid); "
                           &" CREATE INDEX 'IDX_irCMS_menuContent_contentVersion' ON ircms_menucontent USING btree (menuid, version);");
            qInstall.execute();
            return false;
        }
        catch(any e) {
            return false;
        }
    }
    
    public boolean function permission() {
        try {
            var qInstall = new Query();
            qInstall.setDatasource(variables.datasource);
            qInstall.setSQL("CREATE SEQUENCE seq_ircms_user_group; "

                           &" CREATE TABLE irCMS_userGroup ( "
                           &"     groupId integer NOT NULL DEFAULT nextval('seq_ircms_user_group'::regclass), "
                           &"     groupName text NOT NULL, "
                           &"     active boolean NOT NULL DEFAULT false, "
                           
                           &"     CONSTRAINT 'PK_irCMS_userGroup_groupId' PRIMARY KEY (groupId), "
                           &"     CONSTRAINT 'UK_irCMS_userGroup_groupName' UNIQUE (groupName) "
                           &" ) "
                           &" WITH ( "
                           &"     OIDS=FALSE "
                           &" ); "
                            
                           &" INSERT INTO irCMS_userGroup (groupName, active) VALUES ('CMS', true); "
                            
                           &" CREATE SEQUENCE seq_ircms_user_role; "
                            
                           &" CREATE TABLE irCMS_userRole ( "
                           &"     roleId integer NOT NULL default nextval('seq_ircms_user_role'::regclass), "
                           &"     roleName text NOT NULL, "
                           &"     active boolean NOT NULL DEFAULT false, "
                           &"     roleValue integer NOT NULL, "
                           
                           &"     CONSTRAINT 'PK_irCMS_userRole_roleId' PRIMARY KEY (roleId), "
                           &"     CONSTRAINT 'UK_irCMS_userRole_roleName' UNIQUE (roleName) "
                           &" ) "
                           &" WITH ( "
                           &"     OIDS=FALSE "
                           &" ); "
                            
                           &" INSERT INTO irCMS_userRole (roleName, active, roleValue) VALUES ('Guest',  true,   0); "
                           &" INSERT INTO irCMS_userRole (roleName, active, roleValue) VALUES ('Leser',  true,  10); "
                           &" INSERT INTO irCMS_userRole (roleName, active, roleValue) VALUES ('Editor', true,  60); "
                           &" INSERT INTO irCMS_userRole (roleName, active, roleValue) VALUES ('Admin',  true, 100); "
                            
                           &" CREATE SEQUENCE seq_ircms_user_permission; "
                            
                           &" CREATE TABLE irCMS_userPermission ( "
                           &"     permissionId integer NOT NULL default nextval('seq_ircms_user_permission'::regclass), "
                           &"     userId integer NOT NULL, "
                           &"     groupId integer NOT NULL, "
                           &"     roleId integer NOT NULL, "
                            
                           &"     CONSTRAINT 'PK_irCMS_userPermission_permissionId' PRIMARY KEY (permissionId), "
                           &"     CONSTRAINT 'UK_irCMS_userPermission_userIdGroupId' UNIQUE (userId, groupId), "
                            
                           &"     CONSTRAINT 'FK_irCMS_userPermission_userId' FOREIGN KEY (userId) REFERENCES ircms_user (userId) ON UPDATE NO ACTION ON DELETE NO ACTION, "
                           &"     CONSTRAINT 'FK_irCMS_userPermission_groupId' FOREIGN KEY (groupId) REFERENCES ircms_userGroup (groupId) ON UPDATE NO ACTION ON DELETE NO ACTION, "
                           &"     CONSTRAINT 'FK_irCMS_userPermission_roleId' FOREIGN KEY (roleId) REFERENCES ircms_userRole (roleId) ON UPDATE NO ACTION ON DELETE NO ACTION "
                           &" ) "
                           &" WITH ( "
                           &"     OIDS=FALSE "
                           &" ); "
                           &" CREATE INDEX 'FKI_irCMS_userPermission_userId' ON irCMS_userPermission USING btree (userId); "
                           &" CREATE INDEX 'FKI_irCMS_userPermission_groupId' ON irCMS_userPermission USING btree (groupId); "
                           &" CREATE INDEX 'FKI_irCMS_userPermission_roleId' ON irCMS_userPermission USING btree (roleId); "
                           &" CREATE INDEX 'IDX_irCMS_userPermission_roleIdGroupId' ON irCMS_userPermission USING btree (userId, groupId); "
                           &" CREATE INDEX 'IDX_irCMS_userPermission_roleIdGroupIdRoleId' ON irCMS_userPermission USING btree (userId, groupId, roleId); "
                           
                           &" INSERT INTO irCMS_userPermission (userId, groupId, roleId) VALUES (1, 1, 4);");
            qInstall.execute();
            return false;
        }
        catch(any e) {
            return false;
        }
    }
}