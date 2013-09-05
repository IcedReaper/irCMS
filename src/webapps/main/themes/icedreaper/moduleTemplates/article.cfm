<cfset article = createObject("component", "irCMS.system.cfc.com.irModules.singleArticle").init(datasource  = application.datasource.user
                                                                                               ,tablePrefix = application.tablePrefix
                                                                                               ,articleId   = 1)>
<cfoutput>
    <section>
        <header>
            <h1>#article.getHeadline()#</h1>
            <h3 class="subtitle">#article.getSubtitle()#</h3>
            <h3 class="creation">Erstellt von <a href="#application.cms.navigation.getUserLink(article.getCreator())#">#application.user.user.getUsername(article.getCreator())#</a> am #article.getCreationDate()# um #article.getCreationTime()#</h3>
        </header>
        <article>#article.getContent()#</article>
    </section>
</cfoutput>