CREATE TABLE ircms_irblog_blog (
  blogid        serial,
  userid        integer NOT NULL,
  active        boolean NOT NULL DEFAULT false,
  releasedate   timestamp with time zone DEFAULT now(),
  title         text    NOT NULL,
  subtitle      text,
  content       text,
  views         integer NOT NULL DEFAULT 0,
  rating        integer NOT NULL DEFAULT 0,
  ratingcounter integer NOT NULL DEFAULT 0,

  CONSTRAINT "PK_irCMS_irBlog_blog_blogId" PRIMARY KEY (blogid),
  CONSTRAINT "FK_irCMS_irBlog_blog_userId" FOREIGN KEY (userid) REFERENCES ircms_user (userid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "UK_irCMS_irBlog_blog_title"  UNIQUE      (title)
);
CREATE INDEX "FKI_irCMS_irBlog_blog_userId"        ON ircms_irblog_blog USING btree (userid);
CREATE INDEX "IDX_irCMS_irBlog_blog_rating"        ON ircms_irblog_blog USING btree (rating);
CREATE INDEX "IDX_irCMS_irBlog_blog_ratingCounter" ON ircms_irblog_blog USING btree (ratingcounter);
CREATE INDEX "IDX_irCMS_irBlog_blog_views"         ON ircms_irblog_blog USING btree (views);

CREATE TABLE ircms_irblog_tag (
  tagid   serial,
  tagname text   NOT NULL,

  CONSTRAINT "PK_irCMS_irBlog_tag_tagId"   PRIMARY KEY (tagid),
  CONSTRAINT "UK_irCMS_irBlog_tag_tagName" UNIQUE      (tagname)
);

CREATE TABLE ircms_irblog_blogtag (
  blogtagid serial,
  blogid    integer NOT NULL,
  tagid     integer NOT NULL,

  CONSTRAINT "PK_ircms_irBlog_blogTag_blogTagId" PRIMARY KEY (blogtagid),
  CONSTRAINT "FK_ircms_irBlog_blogTag_blogId"    FOREIGN KEY (blogid)    REFERENCES ircms_irblog_blog (blogid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_ircms_irBlog_blogTag_tagId"     FOREIGN KEY (tagid)     REFERENCES ircms_irblog_tag  (tagid)  MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "FKI_ircms_irBlog_blogTag_blogId" ON ircms_irblog_blogtag USING btree (blogid);
CREATE INDEX "FKI_ircms_irBlog_blogTag_tagId"  ON ircms_irblog_blogtag USING btree (tagid);