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
    editable        boolean NOT NULL DEFAULT false,
    rework          BOOLEAN NOT NULL default false,

    CONSTRAINT "PK_irCMS_contentStatus_contentStatusId" PRIMARY KEY (contentStatusId),
    CONSTRAINT "UK_irCMS_contentStatus_statusName"      UNIQUE      (statusName),
    CONSTRAINT "UK_irCMS_contentStatus_sortOrder"       UNIQUE      (sortOrder, rework)
);
CREATE INDEX "IDX_irCMS_contentStatus_readyToRelease" ON irCMS_contentStatus USING btree (readyToRelease);
CREATE INDEX "IDX_irCMS_contentStatus_sortOrder"      ON irCMS_contentStatus USING btree (sortOrder);
CREATE INDEX "IDX_irCMS_contentStatus_online"         ON irCMS_contentStatus USING btree (online);
CREATE INDEX "IDX_irCMS_contentStatus_editable"       ON irCMS_contentStatus USING btree (editable);
CREATE INDEX "IDX_irCMS_contentStatus_rework"         ON irCMS_contentStatus USING btree (rework);

INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online, editable, rework) VALUES ('Draft',              1, false, false, true,  false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online, editable, rework) VALUES ('Rework',             1, false, false, true,  true);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online, editable, rework) VALUES ('Review',             3, false, false, false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online, editable, rework) VALUES ('Release Candidate',  4, true,  false, false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online, editable, rework) VALUES ('Released',           6, true,  true,  false, false);
INSERT INTO irCMS_contentStatus (statusName, sortOrder, readyToRelease, online, editable, rework) VALUES ('Offline',            7, false, false, false, false);

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
    userId               integer       NOT NULL,
    creationDate         timestamp with time zone DEFAULT now(),
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
CREATE INDEX "FKI_irCMS_contentVersion_navigationId"    ON irCMS_contentVersion USING btree (navigationId);
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

## Default Settings

INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 1, true, 'de', 'header', 1, 'header');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 2, true, 'de', 'admin',  1, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 3, true, 'de', 'admin',  2, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 4, true, 'de', 'admin',  3, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 5, true, 'de', 'admin',  4, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 6, true, 'de', 'admin',  5, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 7, true, 'de', 'admin',  6, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 8, true, 'de', 'admin',  7, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES ( 9, true, 'de', 'admin',  8, 'admin');
INSERT INTO irCMS_navigation (navigationId, active, language, postion, sortOrder, nameOfNavigationToShow) VALUES (10, true, 'de', 'hidden', 1, 'header');

INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 1, 1, 6, '', null, null,               'Willkommen',     '/',                  1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 2, 1, 6, '', null, '{"Show":"Admin"}', 'Adminpanel',     '/Admin',             1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 3, 1, 6, '', 6,    '{"Show":"Admin"}', 'Userübersicht',  '/Admin/User',        1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 4, 1, 6, '', 7,    '{"Show":"Admin"}', 'Editor',         '/Admin/Editor',      1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 5, 1, 6, '', 8,    '{"Show":"Admin"}', 'Berechtigungen', '/Admin/Permissions', 1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 6, 1, 6, '', 4,    '{"Show":"Admin"}', 'Module',         '/Admin/Module',      1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 6, 1, 6, '', 4,    '{"Show":"Admin"}', 'Themes',         '/Admin/Themes',      1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 8, 1, 6, '', 9,    '{"Show":"Admin"}', 'Errorlog',       '/Admin/Errorlog',    1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES ( 9, 1, 6, '', null, '{"Show":"Admin"}', 'Seiten',         '/Admin/Pages',       1);
INSERT INTO irCMS_contentVersion (navigationId, version, contentVersionId, content, moduleId, moduleAttributes, linkName, sesLink, userId) VALUES (10, 1, 6, '', 6,    null,               'User',           '/',                  1);