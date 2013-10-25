CREATE TABLE ircms_user (
    userid       serial,
    username     text                     NOT NULL,
    email        text                     NOT NULL,
    emailPublic  boolean                  NOT NULL DEFAULT false
    active       boolean                           DEFAULT true,
    themeid      integer                           DEFAULT 1,
    password     text,
    joinDate     timestamp with time zone          DEFAULT now(),
    avatar       text,
    title        text,
    gender       text,
    postcount    integer                           DEFAULT 0,
    homepage     text,
    twitterLink  text,
    facebookLink text,
    githubLink   text,
    hobbies      text,
    showBuddies  boolean                  NOT NULL DEFAULT false
  
    CONSTRAINT "PK_irCMS_user_userId"   PRIMARY KEY (userid),
    CONSTRAINT "FK_irCMS_user_themeId"  FOREIGN KEY (themeid) REFERENCES ircms_theme (themeid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "UK_irCMS_user_username" UNIQUE      (username)
);
CREATE INDEX "FKI_irCMS_user_themeId"         ON ircms_user USING btree (themeid);
CREATE INDEX "FK_irCMS_user_active"           ON ircms_user USING btree (active);
CREATE INDEX "FK_irCMS_user_usernamePassword" ON ircms_user USING btree (username,password);