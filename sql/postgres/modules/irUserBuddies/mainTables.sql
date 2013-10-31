CREATE TABLE irCMS_modules_irUserBuddy_relation (
    relationId serial,
    userId     integer                  NOT NULL,
    buddyId    integer                  NOT NULL,
    
    addDate    timestamp with time zone          DEFAULT now(),
    
    CONSTRAINT "PK_irCMS_modules_irUserBuddy_relation_relationId"  PRIMARY KEY (relationId),
    CONSTRAINT "UK_irCMS_modules_irUserBuddy_relation_connection"  UNIQUE      (userId, buddyId),
    CONSTRAINT "FK_irCMS_modules_irUserBuddy_relation_userId"      FOREIGN KEY (userId)          REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "FK_irCMS_modules_irUserBuddy_relation_buddyUserId" FOREIGN KEY (buddyId)         REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE irCMS_modules_irUserBuddy_message (
    messageId  serial,
    fromUserId integer                  NOT NULL,
    toUserId   integer                  NOT NULL,
    
    sendDate   timestamp with time zone          DEFAULT now(),
    read       boolean                  NOT NULL DEFAULT false,
    replied    boolean                  NOT NULL DEFAULT false,
    
    subject    text                     NOT NULL,
    text       text                     NOT NULL,
    
    
    CONSTRAINT "PK_irCMS_modules_irUserBuddy_message_messageId"  PRIMARY KEY (messageId),
    CONSTRAINT "FK_irCMS_modules_irUserBuddy_message_fromUserId" FOREIGN KEY (fromUserId) REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT "FK_irCMS_modules_irUserBuddy_message_toUserId"   FOREIGN KEY (toUserId)   REFERENCES irCMS_user (userId) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE INDEX "FKI_irCMS_modules_irUserBuddy_message_toUnread"   ON irCMS_modules_userBuddy_message USING btree (toUserId, read);
CREATE INDEX "FKI_irCMS_modules_irUserBuddy_message_fromUnread" ON irCMS_modules_userBuddy_message USING btree (fromUserId, read);