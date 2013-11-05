CREATE TABLE irCMS_validationRule (
    validationRuleId serial,
    ruleName         text NOT NULL,
    rule             text NOT NULL,
    country          text,
    language         text,
    tip              text,
    description      text,
    
    CONSTRAINT "PK_irCMS_validationRule_validationRuleId"        PRIMARY KEY (validationRuleId),
    CONSTRAINT "UK_irCMS_validationRule_ruleNameCountryLanguage" UNIQUE      (ruleName, country, language)
);
CREATE INDEX "IDX_irCMS_validationRule_ruleName"  ON irCMS_validationRule USING btree (ruleName, country, language);

INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('Version',       '^\d+(\.\d+)*$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('ID',            '^\d$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('String',        '.*');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('Email',         '^ *([a-zA-Z0-9.-]+)@((?:[\w-]+[^-]\.)+)([a-zA-Z]{2,4}) *$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('Gender',        '^((fe){0,1}male|none)$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('Homepage',      '\w*\.{0,1}\w{2,255}\.[\w\.]{2,5}');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('Boolean',       '^(true|false)$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('Password',      '.*');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('SimpleJson',    '^\{(\s*"\w*":\s*"\w*",{0,1})*\s*\}$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('SesLink',       '^(/|(/.+)*)$');
INSERT INTO irCMS_validationRule (ruleName, rule) VALUES ('RegExpression', '.*');