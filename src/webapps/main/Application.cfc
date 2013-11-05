﻿component {
    this.sessionmanagement = true;
    this.mappings = {'/org':    expandPath("./system/libs/"),
                     '/system': expandPath("./system/"),
                     '/themes': expandPath("./themes/")};
    
    public boolean function onApplicationStart() {
        application.installSuccessfull = true;
        
        applicationRestart();
    	
        return true;
    }
    
    private boolean function applicationRestart() {
        include "system/appSetup/databaseSettings.cfm";

    	this.initCoreTools();
        this.initCoreCMS();
        this.initCoreUser();
        this.initCoreSecurity();

        this.initCfStatic();

        return true;
    }

    private boolean function initCoreTools() {
        application.tools.tools = createObject("component", "system.cfc.com.IcedReaper.cms.tools.tools").init();
        application.tools.cryption = createObject("component", "system.cfc.com.IcedReaper.cms.tools.cryption").init(structSeparator=';');
        
        application.tools.formValidator = createObject("component", "system.cfc.com.IcedReaper.cms.tools.validator").init(tablePrefix = application.tablePrefix
                                                                                                                         ,datasource  = application.datasource.user);
                                                                                                                         
        application.tools.validatorCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.tools.validatorCRUD").init(tablePrefix = application.tablePrefix
                                                                                                                             ,datasource  = application.datasource.user);
        return true;
    }

    private boolean function initCoreCMS() {
        application.cms.errorHandler = createObject("component", "system.cfc.com.IcedReaper.cms.cms.errorHandler").init(tablePrefix = application.tablePrefix
                                                                                                                       ,datasource  = application.datasource.admin
                                                                                                                       ,tools       = application.tools.tools);

        application.cms.core = createObject("component", "system.cfc.com.IcedReaper.cms.cms.cmsCore").init(tablePrefix = application.tablePrefix
                                                                                                          ,datasource  = application.datasource.user);
        
        application.cms.navigation = createObject("component", "system.cfc.com.IcedReaper.cms.cms.navigation").init(formValidator = application.tools.formValidator
                                                                                                                   ,tablePrefix   = application.tablePrefix
                                                                                                                   ,datasource    = application.datasource.user);
        
        application.cms.themeCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.cms.themeCRUD").init(tablePrefix  = application.tablePrefix
                                                                                                                 ,datasource   = application.datasource.user);
        
        application.cms.moduleCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.cms.moduleCRUD").init(tablePrefix  = application.tablePrefix
                                                                                                                   ,datasource   = application.datasource.user);
        return true;
    }

    private boolean function initCoreUser() {
        application.user.userCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.user.userCRUD").init(cryptionApi   = application.tools.cryption
                                                                                                                 ,formValidator = application.tools.formValidator
                                                                                                                 ,tablePrefix   = application.tablePrefix
                                                                                                                 ,datasource    = application.datasource.admin);

        application.user.search = createObject("component", "system.cfc.com.IcedReaper.cms.user.userSearch").init(cryptionApi  = application.tools.cryption
                                                                                                                 ,tablePrefix  = application.tablePrefix
                                                                                                                 ,datasource   = application.datasource.user);
        return true;
    }

    private boolean function initCoreSecurity() {
        application.security.permission = createObject("component", "system.cfc.com.IcedReaper.cms.security.permission").init(tablePrefix  = application.tablePrefix
                                                                                                                             ,datasource   = application.datasource.user);
        return true;
    }

    private boolean function initCfStatic() {
        var qThemes = application.cms.core.getThemes();

        application.themes = {};

        for(var i = 1; i <= qThemes.getRecordCount(); i++) {
            application.themes[ qThemes.themeName[i] ] = {};
            application.themes[ qThemes.themeName[i] ].cfstatic = createObject("component", "org.cfstatic.cfstatic").init(staticDirectory     = ExpandPath('./themes/#qThemes.themeName[i]#')
                                                                                                                         ,staticUrl           = "/themes/#qThemes.themeName[i]#/"
                                                                                                                         ,includeAllByDefault = false
                                                                                                                         ,forceCompilation    = true
                                                                                                                         ,checkForUpdates     = true
                                                                                                                         ,excludePattern      = '.*/inc_.*');
        }
        return true;
    }
    
    public boolean function onSessionStart() {
    	return true;
    }
    
    public boolean function onRequestStart(required string targetPage) {
    	try {
            if(isDefined("url.reload")) {
        	    this.handleReload(reload=url.reload);
        	}

        	if(application.installSuccessfull) {
                this.handleLoginOut();
                this.handleDefaultVariables();
                this.handleActualUser();
                this.handleSes();
                this.renderContent();

                return true;
            }
            else {
            	// todo: 
            	// initSetup();
            }
        }
        catch('notFound' var notFound) {
            application.cms.errorHandler.processNotFound(themeName=application.cms.core.getDefaultThemeName(), message=notFound.message, detail=notFound.detail);
            return false;
        }
        catch(any var error) {
            application.cms.errorHandler.processError(themeName=application.cms.core.getDefaultThemeName(), message=error.message, detail=error.detail);
            return false;
        }
    }
    
    private boolean function handleReload(required string reload) {
	    var reloadActions = listToArray(arguments.reload, ',');
        for(var i = 1; i <= arrayLen(reloadActions); i++) {
            switch(reloadActions[i]) {
                case 'applicationScope': {
                    this.applicationRestart();
                    break;
                }
                case 'clearCache': {
                    application.tools.tools.clearQueryCache();
                    break;
                }
                case 'cfstatic': {
                    this.initCfStatic();
                    break;
                }
                default: {
                    break;
                }
            }
        }
        
        return true;
    }

    private boolean function handleDefaultVariables() {
        request.language = 'de';
        
        if(isDefined("session") && structKeyExists(session, 'userName')) {
            request.userName   = session.userName;
            request.isLoggedIn = true;
        }
        else {
            request.userName   = "Guest";
            request.isLoggedIn = false;
        }
        
        if(! isDefined("url.ses") || url.ses == '') {
            request.sesLink = '/';
        }
        else {
            request.sesLink = url.ses;
        }

        request.moduleClass = '';
        request.pageTitle   = '';

        return true;
    }

    private boolean function handleLoginOut() {
        if(isDefined("url.login") && ! structIsEmpty(form) && form.username != "") {
            if(application.user.userCRUD.login(username = form.username, password = form.password)) {
                session.userName = form.username;
                location(url=request.sesLink, addToken=false);
            }
            else {
                session.userName = "Guest";
                include template="/themes/#application.cms.core.getDefaultThemeName()#/templates/core/wrongLogin.cfm";
            }
        }
        if(isDefined("url.logout") && isDefined("session") && structKeyExists(session, 'userName')) {
            if(application.user.userCRUD.login(username=form.username, password=form.password)) {
                session.userName = "Guest";
                structClear(session);
            }
            else {
                throw(type="error whiling logout", detail="handleLoginOut");
            }
        }
        return true;
    }

    private boolean function handleActualUser() {
        request.actualUser = createObject("component", "system.cfc.com.IcedReaper.cms.user.user").init(tablePrefix  = application.tablePrefix
                                                                                                      ,datasource   = application.datasource.user
                                                                                                      ,userName     = request.userName);
        
        if(request.actualUser.load()) {
            request.themeName = request.actualUser.getTheme();
            return true;
        }
        else {
            throw(type="error", message="Failed to load User", detail="");
        }
    }

    private boolean function handleSes() {
        var navigationInformation = application.cms.navigation.getNavigationInformation(sesLink=request.sesLink, language=request.language);

        request.actualMenu = application.cms.navigation.getActualNavigation(navigationInformation);
        
        if(request.actualMenu.loadNavigation()) {
            return true;
        }
        else {
            throw(type="error", message="Failed to load Navigation", detail="");
        }
    }

    private boolean function renderContent() {
        saveContent variable="request.content" {
            if(request.actualMenu.checkShowContent()) {
                writeOutput(request.actualMenu.getContent(cleanArticle=false));
            }
            if(request.actualMenu.checkShowModule()) {
                writeOutput(request.actualMenu.getModuleContent());
            }
        }

        return true;
    }

    public boolean function setPageTitle(required string pageTitle) {
        request.pageTitle = arguments.pageTitle;

        return true;
    }
}