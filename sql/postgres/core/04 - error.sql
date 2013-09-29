CREATE TABLE ircms_error (
    errorid serial,
    message text NOT NULL,
    detail  text NOT NULL,
    recdate timestamp with time zone DEFAULT now(),

    CONSTRAINT "PK_irCMS_error_errorId" PRIMARY KEY (errorid)
);
