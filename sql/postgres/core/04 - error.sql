CREATE TABLE irCMS_errorLog (
    errorId serial,
    message text NOT NULL,
    detail  text NOT NULL,
    recDate timestamp with time zone DEFAULT now(),

    CONSTRAINT "PK_irCMS_error_errorId" PRIMARY KEY (errorId)
);
