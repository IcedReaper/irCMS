component {
    this.sessionmanagement = true;
    
    public boolean function onApplicationStart() {
        application.installSuccessfull = true;
        
        applicationRestart();
    	
        return true;
    }
    
    public boolean function applicationRestart() {
        include "system/setup/databaseSettings.cfm";
        application.rootComponentPath = "icedreaper.";

    	// tools
    	application.tools.tools = createObject("component", "system.cfc.com.irCMS.tools.tools").init();
    	application.tools.cryption = createObject("component", "system.cfc.com.irCMS.tools.cryption").init(structSeparator=';');
    	
    	// cms
        application.cms.errorHandler = createObject("component", "system.cfc.com.irCMS.cms.errorHandler").init(tablePrefix = application.tablePrefix
                                                                                                              ,datasource  = application.datasource.user
                                                                                                              ,tools       = application.tools.tools);
        
    	application.cms.navigation = createObject("component", "system.cfc.com.irCMS.cms.navigation").init(errorHandler = application.cms.errorHandler
                                                                                                          ,tablePrefix  = application.tablePrefix
                                                                                                          ,datasource   = application.datasource.user);
        
        // user
        application.user.user = createObject("component", "system.cfc.com.irCMS.user.user").init(errorHandler = application.cms.errorHandler
                                                                                                ,tablePrefix  = application.tablePrefix
                                                                                                ,datasource   = application.datasource.user
                                                                                                ,cryptionApi  = application.tools.cryption);
        
        
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
            if(isDefined("url.login") && ! structIsEmpty(form) && form.username != "") {
                var tmpUserId = application.user.user.login(username=form.username, password=form.password);
                if(tmpUserId != 0) {
                    session.userId = tmpUserId;
                    // TODO: show wrong password page
                }
            }
            if(isDefined("url.logout") && isDefined("session") && structKeyExists(session, 'userId')) {
            	if(application.user.user.login(username=form.username, password=form.password)) {
                	session.userId = 0;
                	structClear(session);
                }
                else {
                	application.cms.errorHandler.processNotFound(themeName='icedreaper_light', type="logout", detail="logout");
                    abort;
                }
            }

            request.language = 'de';
            
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
            	
                request.navigationInformation = application.cms.navigation.getNavigationInformation(sesLink=request.sesLink, language=request.language);
                if(request.navigationInformation.navigationId == 0) {
                    application.cms.errorHandler.processNotFound(themeName='icedreaper_light', type="ses", detail=request.sesLink);
                    abort;
                }
            	request.actualMenu = application.cms.navigation.getActualNavigation(request.navigationInformation);
            	
            	if(request.actualMenu.loadNavigation()) {
            		return true;
            	}
            	else {
                    application.cms.errorHandler.processNotFound(themeName='icedreaper_light', type="ses", detail=request.sesLink);
                    abort;
            	}
            }
            else {
                application.cms.errorHandler.processNotFound(themeName='icedreaper_light', type="user", detail=request.userId);
                abort;
            }
        }
        else {
        	// todo: 
        	// initSetup();
        }
    }
}