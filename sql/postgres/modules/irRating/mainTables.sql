CREATE TABLE irCMS_modules_irRating_settings (
    creatorGroup text DEFAULT 'irRating'::text,
    creatorRole  text DEFAULT 'Editor'::text,
    
    adminGroup   text DEFAULT 'irRating'::text,
    adminRole    text DEFAULT 'Admin'::text
);

CREATE TABLE irCMS_modules_irRating_type (
    typeId       serial,
    typeName     text                     NOT NULL,
    userId       integer                  NOT NULL,
    creationDate timestamp with time zone          DEFAULT now(),
    ratingIcon   text                     NOT NULL,
    subSteps     integer                  NOT NULL DEFAULT 0,
    inUse        boolean                  NOT NULL DEFAULT false,
    
    CONSTRAINT "PK_irCMS_modules_irRating_type_typeId"   PRIMARY KEY (typeId),
	CONSTRAINT "UK_irCMS_modules_irRating_type_typeName" UNIQUE      (typeName),
	CONSTRAINT "FK_irCMS_modules_irRating_type_userId"   FOREIGN KEY (userId) REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE irCMS_modules_irRating_rating (
    ratingId     serial,
    typeId       integer                  NOT NULL,
    userId       integer                  NOT NULL,
    creationDate timestamp with time zone          DEFAULT now(),
    
    rating       float                    NOT NULL,
    headline     text                     NOT NULL,
    teaser       text                     NOT NULL,
    ratingText   text                     NOT NULL,
    
    CONSTRAINT "PK_irCMS_modules_irRating_rating_ratingId" PRIMARY KEY (ratingId),
	CONSTRAINT "UK_irCMS_modules_irRating_tag_tagName"     UNIQUE      (headline),
	CONSTRAINT "FK_irCMS_modules_irRating_rating_userId"   FOREIGN KEY (userId)   REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE irCMS_modules_irRating_tag (
    tagId        serial,
    tagName      text                     NOT NULL,
    userId       integer                  NOT NULL,
    creationDate timestamp with time zone          DEFAULT now(),
    
    CONSTRAINT "PK_irCMS_modules_irRating_tag_tagId"   PRIMARY KEY (tagId),
	CONSTRAINT "UK_irCMS_modules_irRating_tag_tagName" UNIQUE      (tagName),
	CONSTRAINT "FK_irCMS_modules_irRating_tag_userId"  FOREIGN KEY (userId) REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE irCMS_modules_irRating_ratingTag (
    ratingTagId serial,
    ratingId    integer NOT NULL,
    tagId       integer NOT NULL,
    
    CONSTRAINT "PK_irCMS_modules_irRating_ratingTag_ratingTagId" PRIMARY KEY (ratingTagId),
	CONSTRAINT "UK_irCMS_modules_irRating_ratingTag_ratingTag"   UNIQUE      (ratingId, tagId),
	CONSTRAINT "FK_irCMS_modules_irRating_ratingTag_ratingId"    FOREIGN KEY (ratingId)        REFERENCES irCMS_modules_irRating_rating (ratingId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_irCMS_modules_irRating_ratingTag_tagId"       FOREIGN KEY (tagId)           REFERENCES irCMS_modules_irRating_tag    (tagId)    MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
