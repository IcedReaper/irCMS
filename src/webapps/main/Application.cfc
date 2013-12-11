component {
    this.sessionmanagement = true;
    this.sessiontimeout    = createTimespan(1, 0, 0, 0);
    
    this.mappings = {
    	'/org':    expandPath("./system/libs/"),
        '/system': expandPath("./system/"),
        '/themes': expandPath("./themes/")
    };
    
    this.customtagpaths = [
    	expandPath("./system/customTags/com/IcedReaper/i18n/")
    ];
    
    public boolean function onApplicationStart() {
        application.installSuccessfull = true;
        
        applicationRestart();
    	
        return true;
    }
    
    private boolean function applicationRestart() {
        include "system/appSetup/applicationSettings.cfm";

        this.initCoreTools();
        this.initErrorHandler();
        this.initValidation();
        this.initCoreCMS();
        this.initCoreUser();
        this.initCoreSecurity();

        this.initCfStatic();

        return true;
    }

    private boolean function initCoreTools() {
        application.tools.wrapper  = createObject("component", "system.cfc.com.IcedReaper.cms.tools.wrapper");
        
        application.tools.tools    = createObject("component", "system.cfc.com.IcedReaper.cms.tools.tools").init();

        application.tools.cryption = createObject("component", "system.cfc.com.IcedReaper.cms.tools.cryption").init(encryptionKey   = application.encryption.key
                                                                                                                   ,algorithm       = application.encryption.method
                                                                                                                   ,structSeparator = ';');
        
        application.tools.i18n = createObject("component", "system.cfc.com.IcedReaper.cms.tools.i18n").init(tablePrefix      = application.tablePrefix
                                                                                                           ,datasource       = application.datasource.user
                                                                                                           ,fallbackLanguage = 'en');

        application.tools.i18nCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.tools.i18nCRUD").init(tablePrefix = application.tablePrefix
                                                                                                                   ,datasource  = application.datasource.user);
        return true;
    }
    
    private boolean function initErrorHandler() {
        application.error.errorHandler = createObject("component", "system.cfc.com.IcedReaper.cms.error.errorHandler").init(tablePrefix = application.tablePrefix
                                                                                                                           ,datasource  = application.datasource.admin
                                                                                                                           ,tools       = application.tools.tools);
        return true;
    }
    
    private boolean function initValidation() {
        application.validation.validator = createObject("component", "system.cfc.com.IcedReaper.cms.validation.validator").init(tablePrefix = application.tablePrefix
                                                                                                                               ,datasource  = application.datasource.user);
                                                                                                                         
        application.validation.validatorCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.validation.validatorCRUD").init(tablePrefix = application.tablePrefix
                                                                                                                                       ,datasource  = application.datasource.admin);
        
        return true;
    }

    private boolean function initCoreCMS() {
        application.cms.core = createObject("component", "system.cfc.com.IcedReaper.cms.cms.cmsCore").init(tablePrefix = application.tablePrefix
                                                                                                          ,datasource  = application.datasource.user);
        
        application.cms.navigationCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.cms.navigationCRUD").init(formValidator = application.validation.validator
                                                                                                                           ,tablePrefix   = application.tablePrefix
                                                                                                                           ,datasource    = application.datasource.admin);
        
        application.cms.themeCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.cms.themeCRUD").init(tablePrefix  = application.tablePrefix
                                                                                                                 ,datasource   = application.datasource.admin);
        
        application.cms.moduleCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.cms.moduleCRUD").init(tablePrefix  = application.tablePrefix
                                                                                                                   ,datasource   = application.datasource.admin);
        return true;
    }

    private boolean function initCoreUser() {
        application.user.userCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.user.userCRUD").init(cryptionApi   = application.tools.cryption
                                                                                                                 ,formValidator = application.validation.validator
                                                                                                                 ,tablePrefix   = application.tablePrefix
                                                                                                                 ,datasource    = application.datasource.admin);

        application.user.search = createObject("component", "system.cfc.com.IcedReaper.cms.user.userSearch").init(cryptionApi = application.tools.cryption
                                                                                                                 ,tablePrefix = application.tablePrefix
                                                                                                                 ,datasource  = application.datasource.user);
        return true;
    }

    private boolean function initCoreSecurity() {
        application.security.permission = createObject("component", "system.cfc.com.IcedReaper.cms.security.permission").init(tablePrefix = application.tablePrefix
                                                                                                                             ,datasource  = application.datasource.user);
        
        application.security.permissionCRUD = createObject("component", "system.cfc.com.IcedReaper.cms.security.permissionCRUD").init(tablePrefix = application.tablePrefix
                                                                                                                                     ,datasource  = application.datasource.admin);
        
        return true;
    }

    private boolean function initCfStatic() {
        var qThemes = application.cms.core.getThemes();

        application.themes = {};

        for(var i = 1; i <= qThemes.getRecordCount(); i++) {
        	if(qThemes.useCfStatic[i]) {
                application.themes[ qThemes.themeName[i] ] = {};
                application.themes[ qThemes.themeName[i] ].cfstatic = createObject("component", "org.cfstatic.cfstatic").init(staticDirectory     = ExpandPath('./themes/#qThemes.themeName[i]#')
                                                                                                                             ,staticUrl           = "/themes/#qThemes.themeName[i]#/"
                                                                                                                             ,includeAllByDefault = false
                                                                                                                             ,forceCompilation    = true
                                                                                                                             ,checkForUpdates     = true
                                                                                                                             ,excludePattern      = '.*/inc_.*');
            }
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
                this.handleDefaultVariables();
                this.handleLoginOut();
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
            application.error.errorHandler.processNotFound(themeName=application.cms.core.getDefaultThemeName(), errorStruct=notFound);
            return false;
        }
        catch('permissionInsufficient' var permInsufficient) {
            application.error.errorHandler.logError(errorType='Permission Insufficient', errorData=permInsufficient);
            
            module template  = "/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm"
                   message   = permInsufficient.message
                   groupName = listFirst(permInsufficient.detail, ';')
                   roleName  = listLast(permInsufficient.detail, ';');
            
            return false;
        }
        catch(any var error) {
            application.error.errorHandler.processError(themeName=application.cms.core.getDefaultThemeName(), errorStruct=error);
            return false;
        }
    }
    
    private boolean function handleReload(required string reload) {
	    if(application.installSuccessfull) {
            var reloadActions = listToArray(arguments.reload, ',');
            for(var i = 1; i <= arrayLen(reloadActions); i++) {
                switch(reloadActions[i]) {
                    case 'applicationScope': { this.applicationRestart(); break; } // will reload all other
                    case 'cfstatic':         { this.initCfStatic();       break; }
                    case 'tools':            { this.initCoreTools();      break; }
                    case 'validation':       { this.initValidation();     break; }
                    case 'cms':              { this.initCoreCMS();        break; }
                    case 'user':             { this.initCoreUser();       break; }
                    case 'security':         { this.initCoreSecurity();   break; }
                    case 'error':            { this.initErrorHandler();   break; }

                    case 'i18n':       { application.tools.i18n.reload();           break; }
                    case 'clearCache': { application.tools.tools.clearQueryCache(); break; }
                    default: {
                        break;
                    }
                }
            }
        }
        return true;
    }

    private boolean function handleDefaultVariables() {
        request.language = 'de';
        
        if(isDefined("session") && structKeyExists(session, 'userName') && session.userName != 'Guest') {
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
        request.content     = '';

        return true;
    }

    private boolean function handleLoginOut() {
        if(isDefined("url.login") && ! structIsEmpty(form) && form.username != "") {
            if(application.user.userCRUD.login(username = form.username, password = application.tools.cryption.encryptPassword(password=form.password))) {
                session.userName = form.username;
                location(url=request.sesLink, addToken=false);
            }
            else {
                session.userName = "Guest";
                saveContent variable="request.content" {
                    include template="/themes/#application.cms.core.getDefaultThemeName()#/templates/core/wrongLogin.cfm";
                }
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
        var navigationInformation = application.cms.navigationCRUD.getNavigationInformation(sesLink  = request.sesLink,
                                                                                            language = request.language,
                                                                                            userName = request.userName);

        request.actualMenu = application.cms.navigationCRUD.getActualNavigation(navigationInformation);
        
        if(request.actualMenu.loadNavigation()) {
            return true;
        }
        else {
            throw(type="error", message="Failed to load Navigation", detail="");
        }
    }

    private boolean function renderContent() {
        saveContent variable="request.content" {
            // e.g. Failed login
            if(request.content != '') {
                writeOutput(request.content);
            }
            
            if(request.actualMenu.checkShowContent()) {
                writeOutput(request.actualMenu.getContent(themeName=request.actualUser.getTheme(), cleanArticle=true));
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