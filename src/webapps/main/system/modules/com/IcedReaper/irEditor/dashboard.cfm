<cfscript>
	attributes.dashboardData = [];
	attributes.dashboardData[1].statusName = 'Draft';
    attributes.dashboardData[1].pages = [];
    attributes.dashboardData[1].pages[1] = {};
    attributes.dashboardData[1].pages[1].navigationId = 1;
    attributes.dashboardData[1].pages[1].pageName     = "Willkommen";
    attributes.dashboardData[1].pages[1].sesLink      = "/";
    attributes.dashboardData[1].pages[1].status       = "Draft";
    attributes.dashboardData[1].pages[1].version      = 3.0;
    attributes.dashboardData[1].pages[1].lastChangeAt = createDateTime(2013, 11, 04, 18, 32, 24);
    attributes.dashboardData[1].pages[1].lastChangeBy = "IcedReaper";
    
    attributes.dashboardData[2].statusName = 'Online';
    attributes.dashboardData[2].pages = [];
    attributes.dashboardData[2].pages[1] = {};
    attributes.dashboardData[2].pages[1].navigationId = 1;
    attributes.dashboardData[2].pages[1].pageName     = "Willkommen";
    attributes.dashboardData[2].pages[1].sesLink      = "/";
    attributes.dashboardData[2].pages[1].status       = "Online";
    attributes.dashboardData[2].pages[1].version      = 2.0;
    attributes.dashboardData[2].pages[1].lastChangeAt = createDateTime(2013, 10, 30, 18, 32, 24);
    attributes.dashboardData[2].pages[1].lastChangeBy = "IcedReaper";
    
    attributes.dashboardData[3].statusName = 'Offline';
    attributes.dashboardData[3].pages = [];
    attributes.dashboardData[3].pages[1] = {};
    attributes.dashboardData[3].pages[1].navigationId = 1;
    attributes.dashboardData[3].pages[1].pageName     = "Willkommen";
    attributes.dashboardData[3].pages[1].sesLink      = "/";
    attributes.dashboardData[3].pages[1].status       = "Offline";
    attributes.dashboardData[3].pages[1].version      = 1.0;
    attributes.dashboardData[3].pages[1].lastChangeAt = createDateTime(2013, 10, 01, 18, 32, 24);
    attributes.dashboardData[3].pages[1].lastChangeBy = "IcedReaper";
    
    include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/dashboard.cfm";
</cfscript>