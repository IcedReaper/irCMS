CREATE TABLE ircms_theme (
  themeid      serial,
  themename    text    NOT NULL,
  active       boolean          DEFAULT true,
  defaulttheme boolean          DEFAULT false,
  
  CONSTRAINT "PK_irCMS_theme_themeId" PRIMARY KEY (themeid),
  CONSTRAINT "UK_irCMS_theme_name"    UNIQUE      (themename)
);
CREATE INDEX "FK_irCMS_theme_active"    ON ircms_theme USING btree (active);
CREATE INDEX "FK_irCMS_theme_themename" ON ircms_theme USING btree (themename);