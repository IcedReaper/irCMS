<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";
    
    attributes.showPerPage = 30;
    
    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irErrorlog/main.less');
    
    switch(attributes.entities.len()) {
    	case 2: {
            switch(attributes.entities[1]) {
                case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.page', language=request.language): {
                    attributes.page = attributes.entities[2];
                    include "overview.cfm";
                    break;
                }
                case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irErrorlog.links.error', language=request.language): {
                    include "entity.cfm";
                    break;
                }
            }
            break;
        }
    	default: {
            attributes.page = 1;
    		include "overview.cfm";
    		break;
    	}
    }
</cfscript>