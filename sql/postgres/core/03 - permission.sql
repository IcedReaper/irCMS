CREATE TABLE irCMS_permissionRole (
	permissionRoleId serial,
	roleName         text    NOT NULL,
	active           boolean          DEFAULT true,
	sortOrder        integer NOT NULL,
				   
	CONSTRAINT "PK_irCMS_permissionRole_permissionRoleId" PRIMARY KEY (permissionRoleId),
	CONSTRAINT "UK_irCMS_permissionRole_roleName" UNIQUE (roleName)
);
INSERT INTO irCMS_permissionRole (roleName, sortOrder) VALUES ('Reader',  10);
INSERT INTO irCMS_permissionRole (roleName, sortOrder) VALUES ('Editor',  80);
INSERT INTO irCMS_permissionRole (roleName, sortOrder) VALUES ('Admin',  100);

CREATE TABLE irCMS_permissionGroup (
	permissionGroupId serial,
	groupName         text    NOT NULL,
	active            boolean          DEFAULT true,
				   
	CONSTRAINT "PK_irCMS_permissionGroup_permissionGroupId" PRIMARY KEY (permissionGroupId),
	CONSTRAINT "UK_irCMS_permissionGroup_groupName"         UNIQUE      (groupName)
);
INSERT INTO irCMS_permissionGroup (groupName) VALUES ('CMS');

CREATE TABLE irCMS_permission (
	permissionId      serial,
	userId            integer NOT NULL,
	permissionRoleId  integer NOT NULL,
	permissionGroupId integer NOT NULL,
	
	CONSTRAINT "PK_irCMS_permission_permissionId"          PRIMARY KEY (permissionId),
	CONSTRAINT "UK_irCMS_permission_userpermissionGroupId" UNIQUE      (userId, permissionGroupId),
	CONSTRAINT "FK_irCMS_permission_userId"                FOREIGN KEY (userId)            REFERENCES ircms_user            (userId)            ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_permission_permissionRoleId"      FOREIGN KEY (permissionRoleId)  REFERENCES ircms_permissionRole  (permissionRoleId)  ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_permission_permissionGroupId"     FOREIGN KEY (permissionGroupId) REFERENCES ircms_permissionGroup (permissionGroupId) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE INDEX "FKI_irCMS_permission_userId"            ON irCMS_permission USING btree (userId);
CREATE INDEX "FKI_irCMS_permission_permissionRoleId"  ON irCMS_permission USING btree (permissionRoleId);
CREATE INDEX "FKI_irCMS_permission_permissionGroupId" ON irCMS_permission USING btree (permissionGroupId);