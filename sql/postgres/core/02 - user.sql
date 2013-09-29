CREATE TABLE public.ircms_user (
    userid    serial,
    username  text    NOT NULL,
    email     text    NOT NULL,
    avatar    text,
    active    boolean          DEFAULT true,
    themeid   integer          DEFAULT 1,
    postcount integer          DEFAULT 0,
    password  text,
  
    CONSTRAINT "PK_irCMS_user_userId"   PRIMARY KEY (userid),
    CONSTRAINT "FK_irCMS_user_themeId"  FOREIGN KEY (themeid) REFERENCES ircms_theme (themeid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "UK_irCMS_user_username" UNIQUE      (username)
);
CREATE INDEX "FKI_irCMS_user_themeId"         ON ircms_user USING btree (themeid);
CREATE INDEX "FK_irCMS_user_active"           ON ircms_user USING btree (active);
CREATE INDEX "FK_irCMS_user_usernamePassword" ON ircms_user USING btree (username,password);