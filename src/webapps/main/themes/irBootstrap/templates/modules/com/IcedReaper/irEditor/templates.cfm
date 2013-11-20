<!--- Add new modules to the document --->
<script type="html/text" id="moduleAddHandler">
    <div data-type="module" class="addHandler" id="module">
        <a href="#" class="glyphicon glyphicon-picture" title="Titelbild einfügen" data-module="heroImage"><span class="glyphicon glyphicon-plus"></span></a>
        <a href="#" class="glyphicon glyphicon-align-left" title="Textblock einfügen" data-module="textBlock"><span class="glyphicon glyphicon-plus"></span></a>
        <a href="#" class="glyphicon glyphicon-picture" title="Carousel / Slider einfügen" data-module="carousel"><span class="glyphicon glyphicon-plus"></span></a>
    </div>
</script>

<script type="html/text" id="rowAddHandler">
    <div data-type="row" class="addHandler" id="row">
        <div href="#">
            <section class="row">
                <section class="col-md-12">100%</section>
            </section>
        </div>
        <div href="#">
            <section class="row">
                <section class="col-md-6">50%</section>
                <section class="col-md-6">50%</section>
            </section>
        </div>
        <div href="#">
            <section class="row">
                <section class="col-md-3">25%</section>
                <section class="col-md-9">75%</section>
            </section>
        </div>
        <div href="#">
            <section class="row">
                <section class="col-md-3">25%</section>
                <section class="col-md-6">50%</section>
                <section class="col-md-3">25%</section>
            </section>
        </div>
        <div href="#">
            <section class="row">
                <section class="col-md-6">50%</section>
                <section class="col-md-3">25%</section>
                <section class="col-md-3">25%</section>
            </section>
        </div>
        <div href="#">
            <section class="row">
                <section class="col-md-4">33%</section>
                <section class="col-md-8">66%</section>
            </section>
        </div>
        <div href="#">
            <section class="row">
                <section class="col-md-8">66%</section>
                <section class="col-md-4">33%</section>
            </section>
        </div>
    </div>
</script>

<!--- Module prototypes which will be added to the document --->
<script type="html/text" class="contentTemplate" data-type="module" data-module="heroImage">
    <cfmodule template="/themes/irBootstrap/templates/skeleton/heroImage.cfm" backgroundImage="/themes/irBootstrap/img/modules/com/IcedReaper/irEditor/slider-dummy.jpg" content="">
</script>

<script type="html/text" class="contentTemplate" data-type="module" data-module="textBlock">
    <cfmodule template="/themes/irBootstrap/templates/skeleton/textBlock.cfm" text="<h2>Beispielüberschrift</h2><p>Beispieltext</p>">
</script>

<script type="html/text" class="contentTemplate" data-type="module" data-module="carousel">
    <cfmodule template="/themes/irBootstrap/templates/skeleton/slider.cfm" id="newSlider" images="#[]#">
</script>

<!--- Global Handler --->
<script type="html/text" id="deleteHandler">
    <aside class="editButton">
        <div class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></div>
    </aside>
</script>

<!--- Carousel options --->
<script type="html/text" id="carousel_setting">
    <aside class="slider-options widget">
        <fieldset>
            <legend>Optionen</legend>
        </fieldset>
    </aside>
</script>

<script type="html/text" id="carousel_option">
    <div class="form-group">
        <div class="col-md-3 control-label">
            <label>${label}</label>
        </div>
        <div class="col-md-9">
            <input class="form-control" value="${value}">
        </div>
    </div>
</script>

<script type="html/text" id="carousel_slide_options">
    <aside class="editControls widget">
        <fieldset>
            <legend>Optionen des aktuellen Slide</legend>
            <div>
                <button class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-trash"></span> Slide löschen</button>
                <div class="pull-right">
                    <button class="btn btn-primary" id="movePrev"><span clas="glyphicon glyphicon-chevron-left"></span> Eine Position nach vorne</button>
                    <button class="btn btn-primary" id="moveNext"><span clas="glyphicon glyphicon-chevron-right"></span> Eine Position nach hinten</button>
                </div>
            </div>
        </fieldset>
    </aside>
</script>

<script type="html/text" id="carousel_add_slideBtn">
    <button class="btn btn-success"><span class="glyphicon glyphicon-plus"></span></button>
</script>

<script type="html/text" id="carousel_new_slide">
    <div class="item active">
        <img src="/themes/irBootstrap/img/modules/com/IcedReaper/irEditor/slider-dummy.jpg">
        <div class="carousel-caption"></div>
    </div>
</script>

<script type="html/text" id="carousel_new_indicator">
    <li class="active" data-slide-to="${newIndex}" data-target="${id}"></li>
</script>

<!--- heroImage options --->
<script type="html/text" id="heroImage_setting">
    <aside class="editControls widget">
        <fieldset>
            <legend>Optionen</legend>
        </fieldset>
    </aside>
</script>

<script type="html/text" id="heroImage_option">
    <div class="form-group">
        <div class="col-md-3 control-label">
            <label>${label}</label>
        </div>
        <div class="col-md-9">
            <input class="form-control" value="${value}">
        </div>
    </div>
</script>