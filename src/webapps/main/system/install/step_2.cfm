<cfparam name="form.dbType" default="postgres">
<cfset install = createObject("component", "system.cfc.com.irCMS.install.#form.dbType#.install").init(datasource=application.datasource_admin, tablePrefix='irCMS')>
<!DOCTYPE html>
<html lang="de">
    <head>
        <title>Willkommen bei der Installation des irCMS</title>
    </head>
    <body>
        <h1>Willkommen bei der Installation des irCMS</h1>
        <cfflush>
		
        <cfif install.theme('icedreaper')>
			Theme installation successfull!
		<cfelse>
			Theme installation failed!
		</cfif>
		<cfflush>
		
        <cfif install.user('icedreaper', 'admin@icedreaper.net')>
            User installation successfull!
        <cfelse>
            User installation failed!
        </cfif>
        <cfflush>
		
        <cfif install.error()>
            Errorhandling installation successfull!
        <cfelse>
            Errorhandling installation failed!
        </cfif>
        <cfflush>
		
        <cfif install.menu()>
            Navigation installation successfull!
        <cfelse>
            Navigation installation failed!
        </cfif>
        <cfflush>
		
        <cfif install.permission()>
            Permission system installation successfull!
        <cfelse>
            Permission system installation failed!
        </cfif>
        <cfflush>
		
		<cfif form.installIrBlog>
			<cfquery name="qryInstallIrBlog" default="">
				CREATE SEQUENCE seq_ircms_irblog_tags;

                CREATE TABLE ircms_irBlog_tag (
                    tagId integer NOT NULL DEFAULT nextval('seq_ircms_irblog_tags'::regclass),
                    tagName text NOT NULL,
                
                    CONSTRAINT "PK_irCMS_irBlog_tag_tagId" PRIMARY KEY (tagId),
                    CONSTRAINT "UK_irCMS_irBlog_tag_tagName" UNIQUE (tagName)
                )
                WITH (
                    OIDS=FALSE
                );
                
                CREATE SEQUENCE seq_ircms_irblog_blog;
                        
                CREATE TABLE ircms_irBlog_Blog (
                    blogId integer NOT NULL DEFAULT nextval('seq_ircms_irblog_blog'::regclass),
                    userId integer NOT NULL,
                    active boolean NOT NULL DEFAULT false,
                    releaseDate timestamp with time zone DEFAULT now(),
                    title text NOT NULL,
                    subtitle text,
                    content text,
                    views integer NOT NULL default 0,
                    rating integer NOT NULL default 0,
                    ratingCounter integer NOT NULL default 0,
                    
                    CONSTRAINT "PK_irCMS_irBlog_blog_blogId" PRIMARY KEY (blogId),
                    CONSTRAINT "UK_irCMS_irBlog_blog_title" UNIQUE (title),
                    CONSTRAINT "FK_irCMS_irBlog_blog_userId" FOREIGN KEY (userId) REFERENCES ircms_user (userId) ON UPDATE NO ACTION ON DELETE NO ACTION
                )
                WITH (
                    OIDS=FALSE
                );
                CREATE INDEX "FKI_irCMS_irBlog_blog_userId" ON ircms_irBlog_Blog USING btree (userId);
                CREATE INDEX "IDX_irCMS_irBlog_blog_rating" ON ircms_irBlog_Blog USING btree (rating);
                CREATE INDEX "IDX_irCMS_irBlog_blog_ratingCounter" ON ircms_irBlog_Blog USING btree (ratingCounter);
                CREATE INDEX "IDX_irCMS_irBlog_blog_views" ON ircms_irBlog_Blog USING btree (views);
                
                CREATE SEQUENCE seq_ircms_irblog_blogtag;
                
                CREATE TABLE ircms_irBlog_blogTag (
                    blogTagId integer NOT NULL DEFAULT nextval('seq_ircms_irblog_blogtag'::regclass),
                    blogId integer NOT NULL,
                    tagId integer NOT NULL,
                
                    CONSTRAINT "PK_ircms_irBlog_blogTag_blogTagId" PRIMARY KEY (blogTagId),
                    CONSTRAINT "FK_ircms_irBlog_blogTag_blogId" FOREIGN KEY (blogId) REFERENCES ircms_irBlog_Blog (blogId) ON UPDATE NO ACTION ON DELETE NO ACTION,
                    CONSTRAINT "FK_ircms_irBlog_blogTag_tagId" FOREIGN KEY (tagId) REFERENCES ircms_irBlog_tag (tagId) ON UPDATE NO ACTION ON DELETE NO ACTION
                )
                WITH (
                    OIDS=FALSE
                );
                CREATE INDEX "FKI_ircms_irBlog_blogTag_blogId" ON ircms_irBlog_blogTag USING btree (blogId);
                CREATE INDEX "FKI_ircms_irBlog_blogTag_tagId"  ON ircms_irBlog_blogTag USING btree (tagId);
			</cfquery>
        </cfif>
    </body>
</html>