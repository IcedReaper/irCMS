<cfset request.pageTitle = "Usersuche">
<cfoutput>
    <section class="widget">
        <div class="row">
            <div class="col-md-12">
                <header>
                    <h2>Usersuche</h2>
                </header>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form id="userData" class="form-horizontal" role="form" method="post" action="#request.sesLink#">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Nach einem Usernamen suchen" name="userName">
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="button">Suchen!</button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </section>
</cfoutput>