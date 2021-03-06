/**
 * this JavaScript files provites all logic for the page editor
 *
 * @author IcedReaper <Kevin.Lang@gmx.de>
 */
$(function() {
    if($('.content.editable').length === 1) {
        var editor = new irEditor($('.content.editable'));
    }

    $(window).on('scroll', function() {
        if($(window).scrollTop() <= ($('.row#pageOptions').offset().top + $('.row#pageOptions').height())) {
            if($('.row#actionBar').parent().hasClass('container')) {
                $('.row#actionBar').unwrap();
            }
        }
        else {
            if($(window).scrollTop() >= ($('.row#pageOptions').offset().top + $('.row#pageOptions').height())) {
                if(! $('.row#actionBar').parent().hasClass('container')) {
                    $('.row#actionBar').wrap($('<div/>').addClass('container')
                                                        .css({
                                                            position:   'fixed',
                                                            top:        0,
                                                            padding:    '0 15px',
                                                            zIndex:     100,
                                                            marginLeft: '-15px'
                                                        }));
                }
            }
        } 
    });
});

var irEditor = function($editor) {
    var bEditable = true;
    
    var $previewBtn = $('.btn#preview');
    var $editBtn    = $('.btn#edit');
    
    var $fixBtn  = $('.btn#fix');
    var $sortBtn = $('.btn#sort');
    
    $('form#irEditor').on('submit', function() {
        try {
            if(bEditable) {
                cleanupSortable();
                cleanup();
            }
            $('input[name="content"]').val(buildSkeleton());
            setup();
            setupSortable();
            
            return true;
        } 
        catch (error) {
            return false;
        }
    });
    
    var buildSkeleton = function() {
        var buildSubSkeleton = function($selector) {
            var skeletonNode = [];
            
            $selector.each(function(index) {
                skeletonNode[index] = {};
                var lastElement = false;
                
                if($(this).hasClass('row')) {
                    skeletonNode[index].name = 'row';
                }
                if($(this).attr('class').substring(0, 3) === 'col') {
                    skeletonNode[index].name    = 'col';
                    skeletonNode[index].classes = $(this).attr('class');
                }
                if($(this).hasClass('textBlock')) {
                    skeletonNode[index].name = 'textBlock';
                    skeletonNode[index].text = $(this).html();
                    
                    lastElement = true;
                }
                if($(this).hasClass('heroImage')) {
                    skeletonNode[index].name            = 'heroImage';
                    skeletonNode[index].backgroundImage = $('img', $(this)).attr('src');

                    if($('img', $(this)).css('margin-top') !== '' && $('img', $(this)).css('margin-top') !== '0px' && $('img', $(this)).css('margin-top') !== '0') {
                        skeletonNode[index].marginTop = $('img', $(this)).css('margin-top');
                    }

                    if($(this).css('height') !== '' && $(this).css('height') !== '0px' && $(this).css('height') !== '0') {
                        skeletonNode[index].height = $(this).css('height');
                    }
                    
                    if($('div', $(this)).length === 1) {
                        skeletonNode[index].content = $('div', $(this)).html();
                    }
                    
                    lastElement = true;
                }
                if($(this).hasClass('carousel')) {
                    skeletonNode[index].name = 'slider';
                    skeletonNode[index].id   = $(this).attr('id');

                    if(typeof $(this).attr('interval') !== 'undefined') { skeletonNode[index].interval = $(this).attr('interval'); }
                    if(typeof $(this).attr('pause')    !== 'undefined') { skeletonNode[index].pause    = $(this).attr('pause'); }
                    if(typeof $(this).attr('wrap')     !== 'undefined') { skeletonNode[index].wrap     = $(this).attr('wrap'); }
                    
                    skeletonNode[index].images = [];
                    $('.carousel-inner > .item', $(this)).each(function(imageIndex) {
                        skeletonNode[index].images[imageIndex] = {};
                        skeletonNode[index].images[imageIndex].source = $('img', $(this)).attr('src');

                        if(typeof $(this).attr('alt') !== 'undefined') { skeletonNode[index].images[imageIndex].alt = $(this).attr('alt'); }

                        if($('.carousel-caption > h3', $(this)).length === 1) {
                            skeletonNode[index].images[imageIndex].headline = $('.carousel-caption > h3', $(this)).text();
                        }

                        if($('.carousel-caption > span', $(this)).length === 1) {
                            skeletonNode[index].images[imageIndex].description = $('.carousel-caption > span', $(this)).text();
                        }
                    });
                    lastElement = true;
                }
                
                if($(this).children().length > 0 && ! lastElement) {
                    skeletonNode[index].modules = buildSubSkeleton($(this).children());
                }
            });
            
            return skeletonNode;
        }
        
        var skeleton = buildSubSkeleton($('.content.editable'));
        return JSON.stringify(skeleton[0].modules).replace(/\\n/gi, '');
    };
    
    var initItem = {
        'sortable':          function($container) {
            $container = ! isNumeric($container) ? $container : $(this);
            
            $container.sortable({
                items: '.module'
            });
        },
        'deleteHandler':     function($module)    {
            var $module = ! isNumeric($module) ? $module : $(this);
            
            var $editContainer = $($('#deleteHandler').html());
            $editContainer.find('div')
                          .on('click', function() {
                              $(this).closest('.irEditor-wrapper').remove();
                          });
            
            $module.wrap('<div/>')
                   .closest('div')
                   .addClass('irEditor-wrapper')
                   .append($editContainer);
            return $module.closest('.irEditor-wrapper');
        },
        'responsiveHandler': function($container) {
            $container = ! isNumeric($container) ? $container : $(this);
            
            var $responsiveHandler = $($('#responsiveButton').html());
            
            $responsiveHandler.find('button')
                              .on('click', function(e) {
                                  e.preventDefault();
                                  
                                  $('#responsiveSettingDialog').modal()
                                                               .off('hide.bs.modal')
                                                               .on('hide.bs.modal', function() {
                                                                   var setClass = function(name) {
                                                                       $('input[name="'+name+'"]').each(function() {
                                                                           $container.removeClass($(this).val());
                                                                       });
                                                                       
                                                                       $container.addClass($('input[name="'+name+'"]:checked').val());
                                                                   };
                                                                   
                                                                   setClass('extraSmall');
                                                                   setClass('small');
                                                                   setClass('large');
                                                               });
                                  
                                  var checkOptions = function(name) {
                                      $('input[name="'+name+'"][value=""]').prop('checked', true);
                                      $('input[name="'+name+'"]').each(function() {
                                          if($container.hasClass($(this).val())) {
                                              $(this).prop('checked', true);
                                          }
                                      });
                                  };
                                  
                                  checkOptions('extraSmall');
                                  checkOptions('small');
                                  checkOptions('large');
                              });
            
            $container.prepend($responsiveHandler);
            
            return $container;
        },
        'textBlock':         function($textBlock) {
            var $textBlock = ! isNumeric($textBlock) ? $textBlock : $(this);
            
            $textBlock.tinymce({
                theme: "modern",
                plugins: [
                    ["autolink link image lists preview hr anchor"],    //advlist pagebreak charmap
                    ["searchreplace insertdatetime media nonbreaking"], // wordcount visualblocks visualchars fullscreen code
                    ["table contextmenu directionality template paste"] // emoticons
                ],
                menu: { 
                    edit:   {title: 'Edit',   items: 'undo redo | cut copy paste | selectall'}, 
                    view:   {title: 'View',   items: 'visualaid'}, 
                    format: {title: 'Format', items: 'bold italic underline strikethrough superscript subscript | formats | removeformat'}, 
                    table:  {title: 'Table',  items: 'inserttable tableprops deletetable cell row column'}, 
                },
                add_unload_trigger: false,
                schema: "html5",
                inline: true,
                toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
                statusbar: false
            });
            
            return $textBlock;
        },
        'carousel':          function($carousel)  {
            var $carousel = ! isNumeric($carousel) ? $carousel : $(this);
            
            var createOption = function(label, value, inputFunction) {
                var $option = $($('#carousel_option').html()
                                                     .replace(/\$\{label\}/gi, label)
                                                     .replace(/\$\{value\}/gi, value));
                $option.find('input')
                       .on('input', inputFunction);
                
                return $option;
            }
            
            var $settings = $($('#carousel_setting').html());
            $settings.find('fieldset')
                     .append(createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.Interval'], $carousel.attr('data-interal') || '',      function() { $carousel.attr('data-interval', $(this).val()); }))
                     .append(createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.pause'],    $carousel.attr('data-pause')   || 'hover', function() { $carousel.attr('data-pause',    $(this).val()); }))
                     .append(createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.options.wrap'],     $carousel.attr('data-wrap')    || 'true',  function() { $carousel.attr('data-wrap',     $(this).val()); }));
            $carousel.before($settings);
            
            var item_addEditHandler = function($item) {
                var $item = ! isNumeric($item) ? $item : $(this);

                var $pathEdit        = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.path'],     $('img', $item).attr('src') || '',                 function() {
                                                                                                                           $('img', $item).attr('src', $(this).val()); 
                                                                                                                       });
                var $titleEdit       = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.title'],        $('img', $item).attr('alt') || '',                 function() {
                                                                                                                           $('img', $item).attr('alt', $(this).val()); 
                                                                                                                       });
                var $headlineEdit    = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.headline'],  $('.carousel-caption > h3', $item).text() || '',   function() {
                                                                                                                           if($(this).val() !== '') {
                                                                                                                               if($('.carousel-caption > h3', $item).length === 0) {
                                                                                                                                   $('.carousel-caption', $item).prepend($('<h3/>'));
                                                                                                                               }
                                                                                                                               $('.carousel-caption > h3', $item).text($(this).val());
                                                                                                                           }
                                                                                                                           else {
                                                                                                                               $('.carousel-caption > h3', $item).remove();
                                                                                                                           }
                                                                                                                       });
                var $descriptionEdit = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.carousel.actualSlide.description'], $('.carousel-caption > span', $item).text() || '', function() {
                                                                                                                           if($(this).val() !== '') {
                                                                                                                               if($('.carousel-caption > span', $item).length === 0) {
                                                                                                                                   $('.carousel-caption', $item).append($('<span/>'));
                                                                                                                               }
                                                                                                                              $('.carousel-caption > span', $item).text($(this).val());
                                                                                                                           }
                                                                                                                           else {
                                                                                                                               $('.carousel-caption > span', $item).remove();
                                                                                                                           }
                                                                                                                       });
                
                var $slideOptions = $($('#carousel_slide_options').html());
                $slideOptions.find('#deleteBtn').on('click', function(e) {
                                                   // get the actual index
                                                   var itemIndex = function() {
                                                       var itemIndex = 0;
                                                       $('.item', $carousel).each(function(index) {
                                                           if($(this).hasClass('active')) {
                                                               itemIndex = index;
                                                           }
                                                       });

                                                       return itemIndex;
                                                   }();

                                                   // remove the indicator and activate the correct slide and indicator
                                                   if($('li[data-slide-to]:last', $carousel).attr('data-slide-to') != itemIndex) {
                                                       $('li[data-slide-to]:last', $carousel).remove();

                                                       $item.removeClass('active').next('.item').addClass('active');
                                                   }
                                                   else {
                                                       $('li[data-slide-to]:last', $carousel).remove();
                                                       $('li[data-slide-to]:first', $carousel).addClass('active');

                                                       $('.item', $carousel).removeClass('active').first().addClass('active');
                                                   }
                                                   
                                                   // remove item
                                                   $item.remove();
                                               });
                $slideOptions.find('#movePrev').on('click', function(e) {
                                                      e.preventDefault();

                                                      if($item.prev('.item').length >= 1) {
                                                          // move slide
                                                          $item.insertBefore($item.prev('.item'));
                                                          // mark correct indicator
                                                          var indicator = $('.carousel-indicators li.active', $carousel).prev();
                                                          $('.carousel-indicators li.active', $carousel).removeClass('active');
                                                          indicator.addClass('active');
                                                      }
                                                  });
                $slideOptions.find('#moveNext').on('click', function(e) {
                                                          e.preventDefault();
                                                          
                                                          if($item.next('.item').length >= 1) {
                                                              // move slide
                                                              $item.insertAfter($item.next('.item'));
                                                              // mark correct indicator
                                                              var indicator = $('.carousel-indicators li.active', $carousel).next();
                                                              $('.carousel-indicators li.active', $carousel).removeClass('active');
                                                              indicator.addClass('active');
                                                          }
                                                      });
                
                $slideOptions.find('fieldset')
                             .prepend($descriptionEdit)
                             .prepend($headlineEdit)
                             .prepend($titleEdit)
                             .prepend($pathEdit);
                
                $item.append($slideOptions);
            };

            $('.item', $carousel).each(item_addEditHandler);
            
            var $addSlideBtn = $($('#carousel_add_slideBtn').html()).on('click', function(e) {
                                                                           e.preventDefault();
                                                                           
                                                                           var newIndex = $('.item', $carousel).length;
                                                                           
                                                                           var $newSlide = $($('#carousel_new_slide').html());
                                                                           
                                                                           var $newIndicator = $($('#carousel_new_indicator').html()
                                                                                                                             .replace(/\$\{newIndex\}/gi, newIndex)
                                                                                                                             .replace(/\$\{id\}/gi, $carousel.attr('id')));
                                                                           
                                                                           item_addEditHandler($newSlide);
                                                                           
                                                                           $('.active', $carousel).removeClass('active');
                                                                           $('.carousel-indicators', $carousel).append($newIndicator);
                                                                           $('.carousel-inner',      $carousel).append($newSlide);
                                                                       });
            
            $('aside.editButton', $carousel.closest('.irEditor-wrapper')).prepend('&nbsp;')
                                                                         .prepend($addSlideBtn);
            
            return $carousel;
        },
        'heroImage':         function($heroImage) {
            var $heroImage = ! isNumeric($heroImage) ? $heroImage : $(this);
            
            var createOption = function(label, id, value, on, updateFunction) {
                var $option = $($('#heroImage_option').html()
                                                      .replace(/\$\{label\}/gi, label)
                                                      .replace(/\$\{value\}/gi, value)
                                                      .replace(/\$\{id\}/gi,    id));
                if(typeof updateFunction === 'function') {
                    $option.find('input')
                           .on(on, updateFunction);
                }
                return $option;
            };
            
            var backgroundImage = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.path'], 
                                               'src',
                                               $('img', $heroImage).attr('src') || '',
                                               'input',
                                               function() {
                                                   $('img', $heroImage).attr('src', $(this).val())
                                               });
            
            var content = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.description'], 
                                       'description',
                                       $('> div', $heroImage).html() || '',
                                       'change',
                                       null);
            
            var height = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.height'], 
                                      'height',
                                      $heroImage.css('height') || '',
                                      'change',
                                      function() {
                                          $heroImage.css('height', $(this).val())
                                      });
            
            var marginTop = createOption(cfrequest['modules.com.IcedReaper.irEditor.pageEdit.js.heroImage.options.marginTop'], 
                                         'marginTop',
                                         $('img', $heroImage).css('margin-top') || '',
                                         'input',
                                         function() {
                                             $('img', $heroImage).css('margin-top', $(this).val())
                                         });
            
            var $container = $($('#heroImage_setting').html());
            $container.find('fieldset')
                      .append(backgroundImage)
                      .append(height)
                      .append(marginTop)
                      .append(content);
            
            $heroImage.append($container);
            
            $('input', content).tinymce({
                theme: "modern",
                plugins: [
                    ["autolink link image lists preview hr anchor"],    // advlist pagebreak charmap
                    ["searchreplace insertdatetime media nonbreaking"], // wordcount visualblocks visualchars fullscreen code
                    ["table contextmenu directionality template paste"] // emoticons
                ],
                menu: { 
                    edit:   {title: 'Edit',   items: 'undo redo | cut copy paste | selectall'}, 
                    format: {title: 'Format', items: 'bold italic underline strikethrough superscript subscript | formats | removeformat'}, 
                },
                add_unload_trigger: false,
                schema: "html5",
                toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link ",
                statusbar: false,
                setup: function(ed) {
                    ed.on("change", function(event) {
                        if($('> div', $heroImage).length === 0) {
                            $heroImage.prepend($('<div/>'));
                        }
                        $('> div', $heroImage).html(ed.getContent());
                    });
                }
            });
            
            return $heroImage;
        }
    };
    
    var cleanupItem = {
        'sortable':  function($container) {
            $container = ! isNumeric($container) ? $container : $(this); 
            
            $container.sortable('destroy');
        },
        'textBlock': function($textBlock) {
            var $textBlock = ! isNumeric($textBlock) ? $textBlock : $(this);
            
            $textBlock.tinymce().remove();
        },
        'carousel':  function($carousel)  {
            var $carousel = ! isNumeric($carousel) ? $carousel : $(this);
            
            $('.content.editable aside.slider-options').remove();
        },
        'heroImage': function($heroImage) {
            var $heroImage = ! isNumeric($heroImage) ? $heroImage : $(this);
        }
    
    };
    var initAddHandler    = function() {
        var createModuleAddHandler = function() {
            var $addHandler = $($('#moduleAddHandler').html());

            $addHandler.find('a[data-module]')
                       .on('click', function(e) {
                           e.preventDefault();
                           
                           var $anchor     = $(this);
                           var $addHandler = $anchor.closest('.addHandler');
                           var type        = $addHandler.attr('data-type');
                           var module      = $anchor.attr('data-module');
                           
                           var newModule = $($('.contentTemplate[data-type="'+type+'"][data-module="'+module+'"]').html());
                           var classes = newModule.attr('class');
                           newModule = initItem.deleteHandler(newModule);
                           
                           newModule.append(createModuleAddHandler());
                           $addHandler.closest('.irEditor-wrapper')
                                      .after(newModule);
                           
                           var $module = $('.'+classes.replace(/ /gi, '.'), newModule);
                           initItem[module]($module);
                       });
            
            return $addHandler;
        };
        
        $('.irEditor-wrapper', $('.content.editable')).append(createModuleAddHandler());
        $('.content.editable .row > section').each(function() {
            $(this).find('.irEditor-wrapper:first').before(createModuleAddHandler().wrap($('<div/>').addClass('irEditor-wrapper'))
                                                                                   .closest('.irEditor-wrapper'));
        });
        
        var createRowAddHandler = function() {
            var $rowAddHandler = $($('#rowAddHandler').html());
            
            $rowAddHandler.find('> div')
                          .on('click', function() {
                              var $newRow = $($(this).html());
                              
                              $newRow.find('> section')
                                         .text('')
                                         .each(function() {
                                             $(this).append(initItem.responsiveHandler($(this)))
                                                    .append(createModuleAddHandler().wrap($('<div/>').addClass('irEditor-wrapper'))
                                                                                    .closest('.irEditor-wrapper'));
                                         });
                              
                              $rowAddHandler.after(createRowAddHandler())
                                            .after($newRow);
                          });
            
            return $rowAddHandler;
        };
        
        $('> .row', $('.content.editable')).after(createRowAddHandler());
        $('> .row:first-child', $('.content.editable')).before(createRowAddHandler());
    };
    var cleanupAddHandler = function() {
        $('.addHandler').remove();
    };
    
    $previewBtn.on('click', function(e) {
        e.preventDefault();
        
        cleanup(false);
        bEditable = false;
    });
    $editBtn.on('click',    function(e) {
        e.preventDefault();
        
        setup(false);
        bEditable = true;
    });
    
    $fixBtn.on('click',  function(e) {
        e.preventDefault();
        
        $fixBtn.hide();
        $sortBtn.show();
        
        if(bEditable) {
            setup(false);
        }
        
        cleanupSortable();
    });
    $sortBtn.on('click', function(e) {
        e.preventDefault();
        
        $fixBtn.show();
        $sortBtn.hide();
        
        if(bEditable) {
            cleanup(false);
        }
        
        setupSortable();
    });
    
    var setup   = function(changeSortableButton) {
        $('.module', $editor).each(initItem.deleteHandler);
        $('.content.editable > section.row').find('> section').each(initItem.responsiveHandler);
        initAddHandler();
        
        // modules
        $('.module.textBlock').each(initItem.textBlock);
        $('.module.carousel').each(initItem.carousel);
        $('.module.heroImage').each(initItem.heroImage);
        
        $previewBtn.show();
        $editBtn.hide();
        
        if(changeSortableButton) {
            $fixBtn.hide();
            $sortBtn.show();
        }
    };
    var cleanup = function(changeSortableButton) {
        $('.content.editable aside.editButton').remove();
        $('.content.editable aside.responsiveEdit').remove();
        $('.module', $editor).unwrap();
        
        cleanupAddHandler();
        
        // modules
        $('.module.textBlock[id^="mce_"]').each(cleanupItem.textBlock);
        $('.content.editable aside.editControls').remove();
        $('.module.carousel').each(cleanupItem.carousel);
        $('.module.heroImage').each(cleanupItem.heroImage);
        
        $('.irEditor-wrapper:empty').remove();
        
        $previewBtn.hide();
        $editBtn.show();
        
        if(changeSortableButton) {
            $fixBtn.show();
            $sortBtn.hide();
        }
    };
    
    var setupSortable   = function() {
        $('.content.editable > section.row').find('> section').each(initItem.sortable);
    };
    var cleanupSortable = function() {
        $('.content.editable > section.row').find('> section').each(cleanupItem.sortable);
    };
    
    setup(true);
};