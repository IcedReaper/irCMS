component {
    import "system.interfaces.com.irCMS.*";    

    public singleArticle function init(required string datasource, required string tablePrefix, required numeric articleId) {
    	variables.datasource  = arguments.datasource;
    	variables.tablePrefix = arguments.tablePrefix;
    	variables.articleId   = arguments.articleId;
    	
    	variables.article.headline[1]     = 'Headline';
    	variables.article.subtitle[1]     = 'Untertitel';
    	variables.article.creationDate[1] = dateConvert('local2Utc', now());
    	variables.article.creatorId[1]    = 1;
    	variables.article.content[1]      = 'Dies wäre der wunderbare Content mit einem div Tag <div>Hallo von hierdrin!!!</div>';
    	
    	return this;
    }
    
    public string function getHeadline() {
    	return variables.article.headline[1];
    }
    
    public string function getSubtitle() {
        return variables.article.subtitle[1];
    }
    
    public string function getCreationDate(string dateFormat='DD. MMM YYYY') {
        return dateFormat(dateConvert('utc2Local', variables.article.creationDate[1]), arguments.dateFormat);
    }
    
    public string function getCreationTime(string timeFormat='HH:MM:SS') {
        return timeFormat(dateConvert('utc2Local', variables.article.creationDate[1]), arguments.timeFormat);
    }
    
    public string function getCreator() {
    	return variables.article.creatorId[1];
    }
    
    public string function getContent() {
    	return variables.article.content[1];
    }
}