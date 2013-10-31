CREATE TABLE irCMS_modules_irBlog_blog (
  blogId        serial,
  userId        integer NOT NULL,
  active        boolean NOT NULL DEFAULT false,
  releaseDate   timestamp with time zone DEFAULT now(),
  title         text    NOT NULL,
  subtitle      text,
  content       text,
  views         integer NOT NULL DEFAULT 0,
  rating        integer NOT NULL DEFAULT 0,
  ratingCounter integer NOT NULL DEFAULT 0,

  CONSTRAINT "PK_irCMS_modules_irBlog_blog_blogId" PRIMARY KEY (blogid),
  CONSTRAINT "FK_irCMS_modules_irBlog_blog_userId" FOREIGN KEY (userid) REFERENCES irCMS_user (userid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "UK_irCMS_modules_irBlog_blog_title"  UNIQUE      (title)
);
CREATE INDEX "FKI_irCMS_modules_irBlog_blog_userId"        ON irCMS_modules_irBlog_blog USING btree (userid);
CREATE INDEX "IDX_irCMS_modules_irBlog_blog_rating"        ON irCMS_modules_irBlog_blog USING btree (rating);
CREATE INDEX "IDX_irCMS_modules_irBlog_blog_ratingCounter" ON irCMS_modules_irBlog_blog USING btree (ratingcounter);
CREATE INDEX "IDX_irCMS_modules_irBlog_blog_views"         ON irCMS_modules_irBlog_blog USING btree (views);

CREATE TABLE ircms_modules_irBlog_tag (
  tagid   serial,
  tagName text   NOT NULL,

  CONSTRAINT "PK_irCMS_modules_irBlog_tag_tagId"   PRIMARY KEY (tagId),
  CONSTRAINT "UK_irCMS_modules_irBlog_tag_tagName" UNIQUE      (tagName)
);
CREATE INDEX "IDX_irCMS_modules_irBlog_tag_tagName" ON ircms_modules_irBlog_tag USING btree (tagName);

CREATE TABLE irCMS_modules_irBlog_blogTag (
  blogTagId serial,
  blogId    integer NOT NULL,
  tagId     integer NOT NULL,

  CONSTRAINT "PK_irCMS_modules_irBlog_blogTag_blogTagId" PRIMARY KEY (blogtagid),
  CONSTRAINT "FK_irCMS_modules_irBlog_blogTag_blogId"    FOREIGN KEY (blogid)    REFERENCES ircms_modules_irBlog_blog (blogid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_irCMS_modules_irBlog_blogTag_tagId"     FOREIGN KEY (tagid)     REFERENCES ircms_modules_irBlog_tag  (tagid)  MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "FKI_irCMS_modules_irBlog_blogTag_blogId" ON irCMS_modules_irblog_blogTag USING btree (blogid);
CREATE INDEX "FKI_irCMS_modules_irBlog_blogTag_tagId"  ON irCMS_modules_irblog_blogTag USING btree (tagid);