﻿<script type="html/text" id="moduleAddHandler">
    <div data-type="module" class="addHandler">
        <a href="#" class="glyphicon glyphicon-picture" title="Titelbild einfügen" data-module="heroImage"><span class="glyphicon glyphicon-plus"></span></a>
        <a href="#" class="glyphicon glyphicon-align-left" title="Textblock einfügen" data-module="textBlock"><span class="glyphicon glyphicon-plus"></span></a>
        <a href="#" class="glyphicon glyphicon-picture" title="Carousel / Slider einfügen" data-module="carousel"><span class="glyphicon glyphicon-plus"></span></a>
    </div>
</script>

<script type="html/text" id="rowAddHandler">
    <!---<div data-type="row" class="addHandler">
        <a title="Spaltenaufteilung von 12 einzelnen Einheiten einfügen" data-module="12" class="glyphicon glyphicon-plus" href="#"></a>
    </div>--->
</script>

<script type="html/text" class="contentTemplate" data-type="module" data-module="heroImage">
    <cfmodule template="/themes/irBootstrap/templates/skeleton/heroImage.cfm" backgroundImage="" content="">
</script>

<script type="html/text" class="contentTemplate" data-type="module" data-module="textBlock">
    <cfmodule template="/themes/irBootstrap/templates/skeleton/textBlock.cfm" text="<h2>Beispielüberschrift</h2><p>Beispieltext</p>">
</script>

<script type="html/text" class="contentTemplate" data-type="module" data-module="carousel">
    <cfmodule template="/themes/irBootstrap/templates/skeleton/slider.cfm" id="newSlider" images="#[]#">
</script>

<script type="html/text" id="deleteHandler">
    <aside class="editButton">
        <div class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></div>
    </aside>
</script>