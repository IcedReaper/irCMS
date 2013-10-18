CREATE TABLE irCMS_module (
	moduleId         serial,
	moduleName       text,
	path             text,
	active           boolean                           DEFAULT true,
	userId           integer                  NOT NULL,
	installationDate timestamp with time zone          DEFAULT now(),
	systemModule     boolean                  NOT NULL DEFAULT false,

	CONSTRAINT "PK_irCMS_module_moduleId"       PRIMARY KEY (moduleId),
	CONSTRAINT "UK_irCMS_module_moduleName"     UNIQUE      (moduleName),
	CONSTRAINT "UK_irCMS_module_path"           UNIQUE      (path),
	CONSTRAINT "FK_irCMS_contentVersion_userId" FOREIGN KEY (userId)     REFERENCES ircms_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "FKI_irCMS_module_userId" ON irCMS_module USING btree (userId);
CREATE INDEX "IDX_irCMS_module_active" ON irCMS_module USING btree (active);