<cfoutput>
    <cfset application.themes.irBootstrap.cfstatic.include('/js/skeleton/slider.js')>
    <article id="carousel-#attributes.id#" class="module carousel slide" data-ride="carousel" <cfif attributes.keyExists('interval')>data-interval="#attributes.interval#"</cfif> <cfif attributes.keyExists('pause')>data-pause="#attributes.pause#"</cfif> <cfif attributes.keyExists('wrap')>data-wrap="#attributes.wrap#"</cfif>>
        <ol class="carousel-indicators">
            <cfloop from="1" to="#attributes.images.len()#" index="position">
                <li data-target="##carousel-#attributes.id#" data-slide-to="#position-1#" <cfif position EQ 1>class="active"</cfif>></li>
            </cfloop>
        </ol>

        <div class="carousel-inner">
            <cfloop from="1" to="#attributes.images.len()#" index="image">
                <div class="item <cfif image eq 1>active</cfif>">
                    <img src="#attributes.images[image].source#" <cfif attributes.images[image].keyExists('alt')>alt="#attributes.images[image].alt#"</cfif>>
                    <div class="carousel-caption">
                        <cfif attributes.images[image].keyExists('caption')>
                            <cfif attributes.images[image].caption.keyExists('headline')>
                                <h3>#attributes.images[image].caption.headline#</h3>
                            </cfif>
                            <cfif attributes.images[image].caption.keyExists('description')>
                                <span>#attributes.images[image].caption.description#</span>
                            </cfif>
                        </cfif>
                    </div>
                </div>
            </cfloop>
        </div>

        <a class="left carousel-control" href="##carousel-#attributes.id#" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="##carousel-#attributes.id#" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </article>
</cfoutput>