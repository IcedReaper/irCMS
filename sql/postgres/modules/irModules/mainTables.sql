CREATE TABLE irCMS_modules_irModule_status (
	statusId   serial,
	statusName text    NOT NULL,
	online     boolean NOT NULL DEFAULT false,

	CONSTRAINT "PK_irCMS_modules_irModule_status_statusId"   PRIMARY KEY (statusId),
	CONSTRAINT "UK_irCMS_modules_irModule_status_statusName" UNIQUE      (statusName)
);
CREATE INDEX "IDX_irCMS_modules_irModule_status_statusName"       ON irCMS_modules_irModule_status USING btree (statusName);
CREATE INDEX "IDX_irCMS_modules_irModule_status_statusNameOnline" ON irCMS_modules_irModule_status USING btree (statusName, online);

CREATE TABLE irCMS_modules_irModule_entity (
	entityId     serial,
	entityName   text    NOT NULL,
	active       boolean NOT NULL DEFAULT false,
	subline      text,
	descriptions text,
	statusId     integer NOT NULL,

	userId       integer,
	userName     text,
	creationDate timestamp with time zone DEFAULT now(),
	
	CONSTRAINT "PK_irCMS_modules_irModule_entity_entityId"   PRIMARY KEY (entityId),
	CONSTRAINT "UK_irCMS_modules_irModule_entity_entityName" UNIQUE      (entityName),
	CONSTRAINT "FK_irCMS_modules_irModule_entity_statusId"   FOREIGN KEY (statusId) REFERENCES irCMS_modules_irModules_status (statusId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_modules_irModule_entity_userId"     FOREIGN KEY (userId)   REFERENCES irCMS_user                     (userId)   MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "IDX_irCMS_modules_irModule_entity_active"           ON irCMS_modules_irModules_entity USING btree (active);
CREATE INDEX "IDX_irCMS_modules_irModule_entity_entityNameActive" ON irCMS_modules_irModules_entity USING btree (entityName, active);
CREATE INDEX "FKI_irCMS_modules_irModule_entity_statusId"         ON irCMS_modules_irModules_entity USING btree (statusId);
CREATE INDEX "FKI_irCMS_modules_irModule_entity_userId"           ON irCMS_modules_irModules_entity USING btree (userId);

CREATE TABLE irCMS_modules_irModule_tag (
	tagId         serial,
	tagName       text    NOT NULL,
	entityCounter integer NOT NULL DEFAULT 0,

	userId        integer,
	creationDate  timestamp with time zone DEFAULT now(),

	CONSTRAINT "PK_irCMS_modules_irModule_tag_tagId"   PRIMARY KEY (tagId),
	CONSTRAINT "UK_irCMS_modules_irModule_tag_tagName" UNIQUE      (tagName),
	CONSTRAINT "FK_irCMS_modules_irModule_tag_userId"  FOREIGN KEY (userId)  REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "IDX_irCMS_modules_irModule_tag_tagName" ON irCMS_modules_irModules_tag USING btree (tagName);
CREATE INDEX "FKI_irCMS_modules_irModule_tag_userId"  ON irCMS_modules_irModules_tag USING btree (userId);

CREATE TABLE irCMS_modules_irModule_entityTag (
	entityTagId  serial,
	entityId     integer NOT NULL,
	tagId        integer NOT NULL,

	userId       integer NOT NULL,
	creationDate timestamp with time zone DEFAULT now(),

	CONSTRAINT "PK_irCMS_modules_irModule_entityTag_entityTagId"   PRIMARY KEY (entityTagId),
	CONSTRAINT "UK_irCMS_modules_irModule_entityTag_entityIdTagId" UNIQUE      (entityId, tagId),
	CONSTRAINT "FK_irCMS_modules_irModule_entityTag_userId"        FOREIGN KEY (userId)          REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "IDX_irCMS_modules_irModule_entityTag_entityIdTagId" ON irCMS_modules_irModules_entityTag USING btree (entityId, tagId);
CREATE INDEX "FKI_irCMS_modules_irModule_entityTag_userId"        ON irCMS_modules_irModules_entityTag USING btree (userId);
