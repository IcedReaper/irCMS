<cfoutput>
	<!--- Add new modules to the document --->
	<script type="html/text" id="moduleAddHandler">
	    <div data-type="module" class="addHandler" id="module">
	        <a href="##" class="glyphicon glyphicon-picture" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.moduleAddHandler.heroImage'>" data-module="heroImage"><span class="glyphicon glyphicon-plus"></span></a>
	        <a href="##" class="glyphicon glyphicon-align-left" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.moduleAddHandler.textBlock'>" data-module="textBlock"><span class="glyphicon glyphicon-plus"></span></a>
	        <a href="##" class="glyphicon glyphicon-picture" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.moduleAddHandler.carousel'>" data-module="carousel"><span class="glyphicon glyphicon-plus"></span></a>
	    </div>
	</script>
	
	<!--- add new container to the document --->
	<script type="html/text" id="rowAddHandler">
	    <div data-type="row" class="addHandler" id="row">
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-12 col-sm-12 col-md-12 col-lg-12">100%</section>
	            </section>
	        </div>
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-6 col-sm-6 col-md-6 col-lg-6">50%</section>
	                <section class="col-xs-6 col-sm-6 col-md-6 col-lg-6">50%</section>
	            </section>
	        </div>
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-3 col-sm-3 col-md-3 col-lg-3">25%</section>
	                <section class="col-xs-9 col-sm-9 col-md-9 col-lg-9">75%</section>
	            </section>
	        </div>
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-3 col-sm-3 col-md-3 col-lg-3">25%</section>
	                <section class="col-xs-6 col-sm-6 col-md-6 col-lg-6">50%</section>
	                <section class="col-xs-3 col-sm-3 col-md-3 col-lg-3">25%</section>
	            </section>
	        </div>
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-6 col-sm-6 col-md-6 col-lg-6">50%</section>
	                <section class="col-xs-3 col-sm-3 col-md-3 col-lg-3">25%</section>
	                <section class="col-xs-3 col-sm-3 col-md-3 col-lg-3">25%</section>
	            </section>
	        </div>
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-4 col-sm-4 col-md-4 col-lg-4">33%</section>
	                <section class="col-xs-8 col-sm-8 col-md-8 col-lg-8">66%</section>
	            </section>
	        </div>
	        <div href="##">
	            <section class="row">
	                <section class="col-xs-8 col-sm-8 col-md-8 col-lg-8">66%</section>
	                <section class="col-xs-4 col-sm-4 col-md-4 col-lg-4">33%</section>
	            </section>
	        </div>
	    </div>
	</script>
	
	<!--- Responsive handler --->
	<script type="html/text" id="responsiveButton">
	    <aside class="responsiveEdit">
	        <button class="btn btn-default" title="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.title'>">
	            <span class="glyphicon glyphicon-edit"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.buttonCaption'>
	        </button>
	    </aside>
	</script>
	
    <cfset sizes = [3,4,6,8,9,12]>
	<div class="modal fade" id="responsiveSettingDialog" tabindex="-1" role="dialog" aria-labelledby="responsiveSettings" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	        <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	            <h4 class="modal-title" id="responsiveSettings"><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.title'></h4>
	        </div>
	        <div class="modal-body">
	            <div class="row">
    	            <div class="col-md-6">
        	            <div class="form-group">
        	                <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.extraSmall'></label>
        	                <div class="col-lg-9">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" value="" name="extraSmall">
                                            </span>
                                            <input type="text" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.noSetting'>" disabled="disabled" class="form-control">
                                        </div>
                                    </div>
                                </div>
        	                    <div class="row">
        	                        <div class="col-md-12">
        	                            <div class="input-group">
        	                                <span class="input-group-addon">
        	                                    <input type="radio" value="hidden-xs" name="extraSmall">
        	                                </span>
        	                                <input type="text" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.hide'>" disabled="disabled" class="form-control">
        	                            </div>
        	                        </div>
        	                    </div>
        	                    <cfloop from="1" to="#sizes.len()#" index="sizeIndex">
        	                        <div class="row">
        	                            <div class="col-md-12">
        	                                <div class="input-group">
        	                                    <span class="input-group-addon">
        	                                        <input type="radio" value="col-xs-#sizes[sizeIndex]#" name="extraSmall">
        	                                    </span>
        	                                    <input type="text" value="col-xs-#sizes[sizeIndex]#" disabled="disabled" class="form-control">
        	                                </div>
        	                            </div>
        	                        </div>
        						</cfloop>
        	                </div>
        	            </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.small'></label>
                            <div class="col-lg-9">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" value="" name="small">
                                            </span>
                                            <input type="text" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.noSetting'>" disabled="disabled" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" value="hidden-sm" name="small">
                                            </span>
                                            <input type="text" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.hide'>" disabled="disabled" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <cfloop from="1" to="#sizes.len()#" index="sizeIndex">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" value="col-sm-#sizes[sizeIndex]#" name="small">
                                                </span>
                                                <input type="text" value="col-sm-#sizes[sizeIndex]#" disabled="disabled" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                </cfloop>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-lg-3 control-label"><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.large'></label>
                            <div class="col-lg-9">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" value="" name="large">
                                            </span>
                                            <input type="text" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.noSetting'>" disabled="disabled" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">
                                                <input type="radio" value="hidden-lg" name="large">
                                            </span>
                                            <input type="text" value="<cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.hide'>" disabled="disabled" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <cfloop from="1" to="#sizes.len()#" index="sizeIndex">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input type="radio" value="col-lg-#sizes[sizeIndex]#" name="large">
                                                </span>
                                                <input type="text" value="col-lg-#sizes[sizeIndex]#" disabled="disabled" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                </cfloop>
                            </div>
                        </div>
                    </div>
                </div>
	        </div>
	        <div class="modal-footer">
	            <button type="button" class="btn btn-primary" data-dismiss="modal"><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.responsive.save'></button>
	        </div>
	        </div>
	    </div>
	</div>
	
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
	            <legend><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.carousel.options.headline'></legend>
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
	            <legend><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.carousel.actualSlide.headline'></legend>
	            <div>
	                <button class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-trash"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.templates.carousel.actualSlide.delete'></button>
	                <div class="pull-right">
	                    <button class="btn btn-primary" id="movePrev"><span class="glyphicon glyphicon-chevron-left"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.templates.carousel.actualSlide.movePrev'></button>
	                    <button class="btn btn-primary" id="moveNext"><span class="glyphicon glyphicon-chevron-right"></span> <cf_translation keyName='modules.com.IcedReaper.irEditor.templates.carousel.actualSlide.moveNext'></button>
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
	            <legend><cf_translation keyName='modules.com.IcedReaper.irEditor.templates.heroImage.options.headline'></legend>
	        </fieldset>
	    </aside>
	</script>
	
	<script type="html/text" id="heroImage_option">
	    <div class="form-group">
	        <div class="col-md-3 control-label">
	            <label>${label}</label>
	        </div>
	        <div class="col-md-9">
	            <input class="form-control" value="${value}" id="${id}">
	        </div>
	    </div>
	</script>
</cfoutput>