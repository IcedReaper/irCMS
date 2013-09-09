component {
    public boolean function onApplicationStart() {
    	application.tablePrefix = 'irCMS';
    	application.installSuccessfull = true;
    	application.datasource.user = 'irCMS';
    	application.datasource.admin = 'irCMS_admin';
    	
    	applicationRestart();
    	
        return true;
    }
    
    public boolean function applicationRestart() {
    	// tools
    	application.tools.tools = createObject("component", "system.cfc.com.irCMS.tools.tools").init();
    	
    	// cms
        application.cms.errorHandler = createObject("component", "system.cfc.com.irCMS.cms.errorHandler").init(tablePrefix = application.tablePrefix
                                                                                                              ,datasource  = application.datasource.user
                                                                                                              ,tools       = application.tools.tools);
        
    	application.cms.navigation = createObject("component", "system.cfc.com.irCMS.cms.navigation").init(tablePrefix = application.tablePrefix
                                                                                                          ,datasource  = application.datasource.user);
        
        application.user.user = createObject("component", "system.cfc.com.irCMS.user.user").init(tablePrefix = application.tablePrefix
                                                                                                ,datasource  = application.datasource.user);
        
        
        return true;
    }
    
    public boolean function onSessionStart() {
    	return true;
    }
    
    public boolean function onRequestStart(required string targetPage) {
    	
    	if(isDefined("url.reload")) {
    		var reloadActions = listToArray(url.reload, ',');
    		for(var i = 1; i <= arrayLen(reloadActions); i++) {
    			switch(reloadActions[i]) {
    				case 'applicationScope': {
    					applicationRestart();
    					break;
    				}
    				default: {
    					break;
    				}
    			}
    		}
    	}
    	
    	if(application.installSuccessfull) {
        	if(isDefined("session") && structKeyExists(session, 'userId')) {
        		request.userId = session.userId;
        	}
        	else {
        		request.userId = 0;
        	}
        	
        	request.actualUser = createObject("component", "system.cfc.com.irCMS.user.singleUser").init(errorHandler = application.cms.errorHandler
        	                                                                                           ,tablePrefix  = application.tablePrefix
        	                                                                                           ,datasource   = application.datasource.user
        	                                                                                           ,userId       = request.userId);
        	
        	if(request.actualUser.load()) {
            	if(! isDefined("url.ses") || url.ses == '') {
            		request.sesLink = '/';
            	}
            	else {
            		request.sesLink = url.ses;
            	}
            	
            	var actualMenuId = application.cms.navigation.getMenuForSes(sesString=request.sesLink);
            	
            	if(actualMenuId == 0) {
            		actualMenuId = application.cms.navigation.getMenuForSes(sesString='');
            		
            		if(actualMenuId == 0) {
            			variables.errorHandler.processNotFound(themeName='icedreaper', type="Navigation", detail="Couldn't find a first page nor a page for #request.sesLink#");
            		}
            	}
            	
            	request.actualMenu = createObject("component", "system.cfc.com.irCMS.cms.singleMenu").init(errorHandler = application.cms.errorHandler
                                                                                                          ,tablePrefix  = application.tablePrefix
                                                                                                          ,datasource   = application.datasource.user
            	                                                                                          ,menuId       = actualMenuId);
            	
            	if(request.actualMenu.load()) {
            		return true;
            	}
            	else {
                    variables.errorHandler.processNotFound(themeName='icedreaper', type="ses", detail=request.ses);
            	}
            }
            else {
                variables.errorHandler.processNotFound(themeName='icedreaper', type="user", detail=request.userId);
            }
        }
        else {
        	// todo: 
        	// initSetup();
        }
    }
}