CREATE TABLE irCMS_i18nKey (
	i18nKeyId    serial,
	i18nName     text    NOT NULL,
	active       boolean NOT NULL DEFAULT true,
	userId	     integer NOT NULL,
	creationDate timestamp with time zone DEFAULT now(),

	CONSTRAINT "PK_irCMS_i18nKey_i18nKeyId" PRIMARY KEY (i18nKeyId),
	CONSTRAINT "FK_irCMS_i18nKey_userId"    FOREIGN KEY (userid) REFERENCES ircms_user (userid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "UK_irCMS_i18nKey_i18nName"  UNIQUE      (i18nName)
);
CREATE INDEX "FKI_irCMS_i18nKey_userId"     ON ircms_i18nkey USING btree (userId);
CREATE INDEX "IDX_irCMS_i18nKey_activeName" ON ircms_i18nkey USING btree (active, i18nName);

CREATE TABLE irCMS_i18nTranslation (
	i18nTranslationId serial,
	i18nKeyId         integer NOT NULL,
	language          char(2) NOT NULL,
	translation       text    NOT NULL,
	
	CONSTRAINT "PK_irCMS_i18nTranslation_i18nTranslationId" PRIMARY KEY (i18nTranslationId),
	CONSTRAINT "FK_irCMS_i18nTranslation_i18nKeyId"         FOREIGN KEY (i18nKeyId) REFERENCES ircms_i18nKey (i18nKeyId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "FKI_irCMS_i18nTranslation_i18nKeyId"   ON irCMS_i18nTranslation USING btree (i18nKeyId);
CREATE INDEX "IDX_irCMS_i18nTranslation_KeyLanguage" ON irCMS_i18nTranslation USING btree (i18nKeyId, language);

CREATE TABLE irCMS_i18nHistory (
	i18nHistoryId serial,
	i18nKeyId     integer NOT NULL,
	userId        integer NOT NULL,
	changeDate    timestamp with time zone DEFAULT now(),
	comment       text,

	CONSTRAINT "PK_irCMS_i18nHistory_i18nHistoryId" PRIMARY KEY (i18nHistoryId),
	CONSTRAINT "FK_irCMS_i18nHistory_i18nKeyId"     FOREIGN KEY (i18nKeyId)     REFERENCES ircms_i18nKey (i18nKeyId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_i18nHistory_userId"        FOREIGN KEY (userid)        REFERENCES ircms_user    (userid)    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "FKI_irCMS_i18nHistory_userId"     ON irCMS_i18nHistory USING btree (userId);
CREATE INDEX "FKI_irCMS_i18nHistory_i18nKeyId"  ON irCMS_i18nHistory USING btree (i18nKeyId);
