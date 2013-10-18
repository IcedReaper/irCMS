CREATE TABLE ircms_navigation (
	navigationid           serial,
	parentNavigationId     integer,
	active                 boolean          DEFAULT false,
	language               char(2) NOT NULL,
	position               text             DEFAULT 'header'::text,
	sortorder              integer NOT NULL DEFAULT 1,
	nameOfNavigationToShow text    NOT NULL default 'header'::text,

	CONSTRAINT "PK_irCMS_navigation_navigationId"       PRIMARY KEY (navigationid),
	CONSTRAINT "FK_irCMS_navigation_parentNavigationId" FOREIGN KEY (parentNavigationId) REFERENCES ircms_navigation (navigationid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "IDX_irCMS_navigation_active"             ON ircms_navigation USING btree (position, language, active, parentnavigationid);
CREATE INDEX "FKI_irCMS_navigation_parentnavigationId" ON ircms_navigation USING btree (parentnavigationid);

CREATE TABLE irCMS_contentStatus (
	contentStatusId serial,
	statusName      text    NOT NULL,
	sortOrder       integer NOT NULL,
	readyToRelease  boolean          DEFAULT false,
	online          boolean NOT NULL DEFAULT false,

	CONSTRAINT "PK_irCMS_contentStatus_contentStatusId" PRIMARY KEY (contentStatusId),
	CONSTRAINT "UK_irCMS_contentStatus_statusName"      UNIQUE      (statusName),
	CONSTRAINT "UK_irCMS_contentStatus_sortOrder"       UNIQUE      (sortOrder)
);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Draft',              1, false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Rework',             2, false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Review',             3, false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Release Candidate',  4, false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Ready to release',   5, true,  false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Released',           6, true,  true);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online) VALUES ('Offline',            7, false, false);

CREATE TABLE irCMS_contentVersion (
	contentVersionId     serial,
	navigationId         integer       NOT NULL,
	version              numeric(10,2) NOT NULL DEFAULT 1,
	contentStatusId      integer       NOT NULL DEFAULT 1,
	content              text,
	moduleId             integer,
	moduleAttributes     text,
	linkName             text,
	sesLink              text          NOT NULL,
	entityRegExp         text                   DEFAULT '':text,
	title                text,
	description          text,
	keywords             text,
	canonical            text,
	userId               integer       NOT NULL,
	versionComment       text,
	showContentForEntity boolean       NOT NULL DEFAULT false,

	CONSTRAINT "PK_irCMS_contentVersion_contentVersionId"  PRIMARY KEY (contentVersionId),
	CONSTRAINT "UK_irCMS_contentVersion_navigationVersion" UNIQUE      (navigationId, version),
	CONSTRAINT "FK_irCMS_contentVersion_navigationId"      FOREIGN KEY (navigationid)          REFERENCES ircms_navigation    (navigationid)    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_contentVersion_userId"            FOREIGN KEY (userId)                REFERENCES ircms_user          (userId)          MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_contentVersion_contentStatusId"   FOREIGN KEY (contentStatusId)       REFERENCES ircms_contentStatus (contentStatusId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN irCMS_contentVersion.showContentForEntity IS 'Should the content be shown before the module when a module has an entity? E.g. When we have an overview we maybe want to show some text before it, but not in the entities.';
COMMENT ON COLUMN irCMS_contentVersion.moduleAttributes     IS 'These mModule attributes can be a subdivision for the original module. E.g. The review module can be separated into CD, DVD/BluRay, Games, concert and so on and so on reviews which shouldn''t be mixed up.';

CREATE INDEX "IDX_irCMS_contentVersion_contentVersion"  ON irCMS_contentVersion USING btree (navigationid, version);
CREATE INDEX "FKI_irCMS_contentVersion_userId"          ON irCMS_contentVersion USING btree (userId);
CREATE INDEX "FKI_irCMS_contentVersion_navigationId" 	ON irCMS_contentVersion USING btree (navigationId);
CREATE INDEX "FKI_irCMS_contentVersion_contentStatusId" ON irCMS_contentVersion USING btree (contentStatusId);

CREATE TABLE irCMS_contentHistory (
	contentHistoryId serial,
	contentVersionId integer NOT NULL,
	contentStatusId  integer NOT NULL,
	language         char(2) NOT NULL,
	userId           integer NOT NULL,
	historyDate      timestamp with time zone DEFAULT now(),
	historyComment   text    NOT NULL,

	CONSTRAINT "PK_irCMS_contentHistory_contentHistoryId" PRIMARY KEY (contentHistoryId),
	CONSTRAINT "FK_irCMS_contentHistory_contentVersionId" FOREIGN KEY (contentVersionId) REFERENCES irCMS_contentVersion (contentVersionId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_contentHistory_contentStatusId"  FOREIGN KEY (contentStatusId)  REFERENCES irCMS_contentStatus  (contentStatusId)  MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_contentHistory_userId"           FOREIGN KEY (userId)           REFERENCES irCMS_user           (userId)           MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "IDX_irCMS_contentHistory_contentVersionLanguage" ON irCMS_contentHistory USING btree (contentVersionId, language);
CREATE INDEX "FKI_irCMS_contentHistory_contentVersionId"       ON irCMS_contentHistory USING btree (contentVersionId);
CREATE INDEX "FKI_irCMS_contentHistory_userId"                 ON irCMS_contentHistory USING btree (userId);