CREATE TABLE irCMS_errorLog (
    errorId serial,
    type    text NOT NULL,
    recDate timestamp with time zone DEFAULT now(),

    CONSTRAINT "PK_irCMS_error_errorId" PRIMARY KEY (errorId)
);
CREATE INDEX "IDX_irCMS_errorLog_type" ON irCMS_errorLog USING btree (type);

CREATE TABLE irCMS_errorLog_detail (
    detailId serial,
    errorId  integer NOT NULL,
    key      text    NOT NULL,
    value    text    NOT NULL,
    
    CONSTRAINT "PK_irCMS_errorLog_detail_detailId" PRIMARY KEY (detailId),
    CONSTRAINT "UK_irCMS_errorLog_detail_errorKey" UNIQUE      (errorId, key),
    CONSTRAINT "FK_irCMS_errorLog_detail_errorId"  FOREIGN KEY (errorId)      REFERENCES irCMS_errorLog (errorId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE irCMS_errorLog_stacktrace (
    stacktraceId  serial,
    errorId       integer NOT NULL,
    chainPosition integer NOT NULL,
    codeHTML      text    NOT NULL,
    templateName  text    NOT NULL,
    type          text    NOT NULL,
    line          integer NOT NULL,
    
    CONSTRAINT "PK_irCMS_errorLog_stacktrace_stacktraceId" PRIMARY KEY (stacktraceId),
    CONSTRAINT "FK_irCMS_errorLog_stacktrace_errorId"      FOREIGN KEY (errorId)      REFERENCES irCMS_errorLog (errorId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);