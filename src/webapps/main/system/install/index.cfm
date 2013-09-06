<!DOCTYPE html>
<html lang="de">
    <head>
        <title>Willkommen bei der Installation des irCMS</title>
    </head>
    <body>
        <h1>Willkommen bei der Installation des irCMS</h1>
        <cfquery name="installTheme" datasource="">
			CREATE SEQUENCE seq_ircms_theme;
			CREATE TABLE irCMS_theme (
              themeId int default nextval('seq_ircms_theme'::regclass) NOT NULL,
              themeName TEXT NOT NULL,
              active boolean DEFAULT true,
              defaultTheme boolean DEFAULT false,
            
              CONSTRAINT "PK_irCMS_theme_themeId" PRIMARY KEY (themeId),
              CONSTRAINT "UK_irCMS_theme_name" UNIQUE (themeName)
            );
            INSERT INTO irCMS_theme (themeName, defaultTheme) VALUES (<cfqueryparam value=form.defaultThemeName cfsqltype="cf_sql_varchar">, true);
		</cfquery>
		
		<cfquery name="installFirstUser" datasource="">
			CREATE SEQUENCE seq_ircms_user;
			CREATE TABLE ircms_user (
              userid integer NOT NULL DEFAULT nextval('seq_ircms_user'::regclass),
              username text NOT NULL,
              email text NOT NULL,
              avatar text,
              active boolean DEFAULT true,
              themeid integer DEFAULT 1,
              postcount integer DEFAULT 0,
              CONSTRAINT "PK_irCMS_user_userId" PRIMARY KEY (userid),
              CONSTRAINT "FK_irCMS_user_themeId" FOREIGN KEY (themeid) REFERENCES public.ircms_theme (themeid) MATCH Unknown ON UPDATE NO ACTION ON DELETE NO ACTION,
              CONSTRAINT "UK_irCMS_user_username" UNIQUE (username)
            )
            WITH (
              OIDS=FALSE
            );
            CREATE INDEX "FKI_irCMS_user_themeId" ON ircms_user USING btree (themeid);
            
            INSERT INTO irCMS_user (userName, email, themeId) VALUES (<cfqueryparam value=form.defaultUsername cfsqltype="cf_sql_varchar">, <cfqueryparam value=form.defaultUserEmail cfsqltype="cf_sql_varchar">, 1);
        </cfquery>
        
        <cfquery name="installError" datasource="">
			CREATE SEQUENCE seq_ircms_error;
            CREATE TABLE irCMS_error(
                errorId int default nextval('seq_ircms_error'::regclass) NOT NULL,
                message TEXT NOT NULL,
                detail TEXT NOT NULL,
                recDate timestamp with time zone,
            
                CONSTRAINT "PK_irCMS_error_errorId" PRIMARY KEY (errorId)
            );
		</cfquery>
		
		<cfquery name="installMenu" datasource="">
			CREATE SEQUENCE seq_ircms_menu;
			
            CREATE TABLE ircms_menu (
              menuid integer NOT NULL DEFAULT nextval('seq_ircms_menu'::regclass),
              parentmenuid integer,
              linkname text NOT NULL,
              ses text NOT NULL,
              recnew timestamp with time zone DEFAULT now(),
              active boolean DEFAULT false,
              title text NOT NULL,
              description text NOT NULL,
              canonical text NOT NULL,
              keywords text NOT NULL,
              CONSTRAINT "PK_irCMS_menu_menuId" PRIMARY KEY (menuid),
              CONSTRAINT "UK_irCMS_menu_ses" UNIQUE (ses)
            )
            WITH (
              OIDS=FALSE
            );
            CREATE INDEX "IDX_irCMS_menu_activeLinks" ON public.ircms_menu USING btree (active, parentmenuid);
            CREATE INDEX "IDX_irCMS_menu_parentMenuId" ON public.ircms_menu USING btree (parentmenuid);
            CREATE INDEX "IDX_irCMS_menu_ses" ON public.ircms_menu USING btree (ses COLLATE pg_catalog."default");
            
            CREATE SEQUENCE seq_ircms_menucontent;
            
            CREATE TABLE ircms_menucontent (
              menucontentid integer NOT NULL DEFAULT nextval('seq_ircms_menucontent'::regclass),
              menuid integer NOT NULL,
              content text NOT NULL,
              version text NOT NULL DEFAULT 'actual'::text,
              active boolean DEFAULT false,
              userid integer NOT NULL,
              recnew timestamp with time zone DEFAULT now(),
              releasedate timestamp with time zone,
              CONSTRAINT "PK_irCMS_menuContent_menuContentId" PRIMARY KEY (menucontentid),
              CONSTRAINT "FK_irCMS_menuContent_menuId" FOREIGN KEY (menuid) REFERENCES public.ircms_menu (menuid) MATCH Unknown ON UPDATE NO ACTION ON DELETE NO ACTION
            )
            WITH (
              OIDS=FALSE
            );
            
            CREATE INDEX "FKI_irCMS_menuContent_menuId" ON public.ircms_menucontent USING btree (menuid);
            CREATE INDEX "IDX_irCMS_menuContent_contentVersion" ON public.ircms_menucontent USING btree (menuid, version COLLATE pg_catalog."default");
		</cfquery>
    </body>
</html>