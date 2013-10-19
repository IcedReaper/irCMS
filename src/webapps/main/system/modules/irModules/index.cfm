<section class="irModules">
<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    application.themes[request.themeName].cfstatic.include('/css/modules/irModules/main.less');
    
    switch(attributes.entities.len()) {
        case 0: {
            switch(attributes.show) {
                case 'Top': {
                    include template="top.cfm";
                    break;
                }
                default: {
                    include template="overview.cfm";
                    break;
                }
            }
            break;
        }
        case 1: {
            switch(attributes.entities[1]) {
                case 'Tags': {
                    include template="tagOverview.cfm";
                    break;
                }
                default: {
                    include template="detail.cfm";
                }
            }
            break;
        }
        case 2: {
            switch(attributes.entities[1]) {
                case 'Tags': {
                    include template="tag.cfm";
                    break;
                }
                case 'Ersteller': {
                    include template="creator.cfm";
                    break;
                }
                case 'Seite': {
                    include template="overview.cfm";
                    break;
                }
                default: {
                    break;
                }
            }
        }
        default: {
            break;
        }
    }
</cfscript>