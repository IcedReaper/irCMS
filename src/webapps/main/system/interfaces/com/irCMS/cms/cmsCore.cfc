﻿interface {
    public cmsCore function init(required string tablePrefix, required string datasource);
    
    public string function renderTemplate(required string themeName);
}