/**
 * this JavaScript files provites all logic for the page editor
 *
 * @author IcedReaper <Kevin.Lang@gmx.de>
 */
$(function() {
    if($('.content.editable').length === 1) {
        var editor = new irEditor($('.content.editable'));
    }
});

var irEditor = function($editor) {
    var isNumeric = function (n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    };
    
    $('form#irEditor').on('submit', function() {
        try {
            cleanup();
            $('input[name="content"]').val(buildSkeleton());
            setup();
            
            return true;
        } 
        catch (error) {
            console.log(error);
            
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
                    skeletonNode[index].backgroundImage = $(this).css('background-image').replace(/(url\("https*:\/\/(\w+\.*)+|"\))/gi, '');
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
        'deleteHandler': function($module) {
            var $module = ! isNumeric($module) ? $module : $(this);
            
            var delButton = $('<div/>').addClass('btn btn-danger')
                                       .append($('<span/>').addClass('glyphicon glyphicon-trash'))
                                       .on('click', function() {
                                           $(this).closest('.irEditor-wrapper').remove();
                                       });
            var editContainer = $('<aside/>').addClass('editButton')
                                             .append(delButton);
            
            $module.wrap('<div/>')
                   .closest('div')
                   .addClass('irEditor-wrapper')
                   .append(editContainer);
            return $module.closest('.irEditor-wrapper');
        },
        'textBlock':     function($textBlock) {
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
        'carousel':      function($carousel) {
            var $carousel = ! isNumeric($carousel) ? $carousel : $(this);
            
            var createOptionControl = function(label, attrName, defaultValue) {
                return $('<div/>').addClass('form-group')
                                  .append($('<div/>').addClass('col-md-3 control-label')
                                                     .append($('<label/>').text(label))
                                         )
                                  .append($('<div/>').addClass('col-md-9')
                                                     .append($('<input/>').addClass('form-control')
                                                                          .val($carousel.attr(attrName) || defaultValue)
                                                                          .on('input', function() {
                                                                              $carousel.attr(attrName, $(this).val());
                                                                          })
                                                            )
                                         );
            }

            $carousel.before($('<aside/>').addClass('slider-options widget')
                                          .append($('<fieldset/>').append($('<legend/>').text('Optionen'))
                                                                  .append(createOptionControl('Interval', 'data-interval', ''))
                                                                  .append(createOptionControl('Pause',    'data-pause', 'hover'))
                                                                  .append(createOptionControl('Wrap',     'data-wrap', 'true'))
                                                 )
                            );

            $('.item', $carousel).each(function() {
                var $item = $(this);

                var createControl = function(label, value, inputFunction) {
                    return $('<div/>').addClass('form-group')
                                      .append($('<div/>').addClass('col-md-3 control-label')
                                                         .text(label))
                                      .append($('<div/>').addClass('col-md-9')
                                                         .append($('<input/>').addClass('form-control')
                                                                              .val(value)
                                                                              .on('input', inputFunction)
                                                                )
                                             );
                };
                
                var pathEdit = createControl('Bildpfad', $('img', $item).attr('src') || '', function() { 
                                                                                                $('img', $item).attr('src', $(this).val()); 
                                                                                            }
                                            );
                
                var titleEdit = createControl('Titel', $('img', $item).attr('alt') || '', function() { 
                                                                                              $('img', $item).attr('alt', $(this).val()); 
                                                                                          }
                                             );
                
                var headlineEdit = createControl('Überschrift', $('.carousel-caption > h3', $item).text(), function() {
                                                                                                               if($(this).val() !== '') {
                                                                                                                   if($('.carousel-caption > h3', $item).length === 0) {
                                                                                                                       $('.carousel-caption', $item).prepend($('<h3/>'));
                                                                                                                   }
                                                                                                                   $('.carousel-caption > h3', $item).text($(this).val());
                                                                                                               }
                                                                                                               else {
                                                                                                                   $('.carousel-caption > h3', $item).remove();
                                                                                                               }
                                                                                                           }
                                                   );
                
                var DescriptionEdit = createControl('Beschreibung', $('.carousel-caption > span', $item).text(), function() {
                                                                                                                     if($(this).val() !== '') {
                                                                                                                         if($('.carousel-caption > span', $item).length === 0) {
                                                                                                                             $('.carousel-caption', $item).append($('<span/>'));
                                                                                                                         }
                                                                                                                        $('.carousel-caption > span', $item).text($(this).val());
                                                                                                                     }
                                                                                                                     else {
                                                                                                                         $('.carousel-caption > span', $item).remove();
                                                                                                                     }
                                                                                                                 }
                                                   );
                $item.append($('<aside/>').addClass('editControls widget')
                                          .append($('<fieldset/>').append($('<legend/>').text('Optionen des aktuellen Slide'))
                                                                  .append(pathEdit)
                                                                  .append(titleEdit)
                                                                  .append(headlineEdit)
                                                                  .append(DescriptionEdit)
                                                 )
                            );
            });
            
            $('aside.editButton', $carousel.closest('.irEditor-wrapper')).prepend($('<div/>').addClass('btn btn-success')
                                                                                             .append($('<span/>').addClass('glyphicon glyphicon-plus'))
                                                                                             .on('click', function() {
                                                                                                 console.log('add slider image');
                                                                                             })
                                                                                             .after('&nbsp;'));
            
            return $carousel;
        },
        'heroImage':     function($heroImage) {
            var $heroImage = ! isNumeric($heroImage) ? $heroImage : $(this);
            
            var createOption = function(label, val, on, updateFunction) {
                return $('<div/>').addClass('form-group')
                                  .append($('<div/>').addClass('col-md-3 control-label')
                                                     .text(label))
                                  .append($('<div/>').addClass('col-md-9')
                                                     .append($('<input/>').addClass('form-control')
                                                                          .val(val)
                                                                          .on(on, updateFunction)
                                                            )
                                         );
            };
            
            var backgroundImage = createOption('Bildpfad', 
                                               $heroImage.css('background-image').replace(/(url\("https*:\/\/(\w+\.*)+|"\))/gi, ''),
                                               'input',
                                               function() {
                                                   $heroImage.css('background-image', "url("+$(this).val()+")")
                                               });
            
            var content = createOption('Beschreibung', 
                                       $('> div', $heroImage).html(),
                                       'change',
                                       null);
            
            var $container = $('<aside/>').addClass('editControls widget')
                                          .append($('<fieldset/>').append($('<legend/>').text('Optionen'))
                                                                  .append(backgroundImage)
                                                                  .append(content)
                                                 );

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
        'textBlock': function($textBlock) {
            var $textBlock = ! isNumeric($textBlock) ? $textBlock : $(this);
            
            $textBlock.tinymce().remove();
        },
        'carousel':  function($carousel) {
            var $carousel = ! isNumeric($carousel) ? $carousel : $(this);
            
            $('.content.editable aside.slider-options').remove();
        },
        'heroImage': function($heroImage) {
            var $heroImage = ! isNumeric($heroImage) ? $heroImage : $(this);
            
        }
    };
    
    var initAddHandler = function() {
        $('.irEditor-wrapper', $('.content.editable')).after($('#moduleAddHandler').html());
        
        $('.addHandler[data-type]').each(function() {
            var $addHandler = $(this);
            $('a[data-module]', $addHandler).on('click', function(e) {
                e.preventDefault();
                
                var $anchor = $(this);
                var type    = $anchor.closest('.addHandler').attr('data-type');
                var module  = $anchor.attr('data-module');
                
                var newModule = $($('.contentTemplate[data-type="'+type+'"][data-module="'+module+'"]').html());
                var classes = newModule.attr('class');
                newModule = initItem.deleteHandler(newModule);
                
                $addHandler.before(newModule);
                
                var $module = $('.'+classes.replace(/ /gi, '.'), newModule);
                initItem[module]($module);
            });
        });
        $('.row', $('.content.editable')).after($('#rowAddHandler').html());
    };
    var cleanupAddHandler = function() {
        $('.addHandler').remove();
    };
    
    var setup = function() {
        $('.module', $editor).each(initItem.deleteHandler);
        
        initAddHandler();
        
        // modules
        $('.module.textBlock').each(initItem.textBlock);
        $('.module.carousel').each(initItem.carousel);
        $('.module.heroImage').each(initItem.heroImage);
    };
    var cleanup = function() {
        $('.content.editable aside.editButton').remove();
        $('.module', $editor).unwrap();
        
        cleanupAddHandler();
        
        // modules
        $('.module.textBlock[id^="mce_"]').each(cleanupItem.textBlock);
        $('.content.editable aside.editControls').remove();
        $('.module.carousel').each(cleanupItem.carousel);
        $('.module.heroImage').each(cleanupItem.heroImage);
    };
    
    setup();
};