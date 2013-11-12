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
    $('form#irEditor').on('submit', function() {
        try {
            // clean
            removeEditHandler();

            cleanupTextBlock();
            cleanupCarousel();
            
            // build
            $('input[name="content"]').val(buildSkeleton());
            
            // restore
            addEditHandler();
            initTextBlock();
            initCarousel();
        
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
                    skeletonNode[index].name = 'col';
                    skeletonNode[index].classes = $(this).attr('class');
                }
                if($(this).hasClass('textBlock')) {
                    skeletonNode[index].name = 'textBlock';
                    skeletonNode[index].text = $(this).html();
                    
                    lastElement = true;
                }
                if($(this).hasClass('heroImage')) {
                    skeletonNode[index].name = 'heroImage';
                    skeletonNode[index].backgroundImage = $(this).css('background-image').replace(/(url\("https*:\/\/(\w+\.*)+|"\))/gi, '');
                    
                    lastElement = true;
                }
                if($(this).hasClass('carousel')) {
                    skeletonNode[index].name   = 'slider';
                    skeletonNode[index].id     = $(this).attr('id');

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

    var addEditHandler = function() {
        $('.module', $editor).each(function() {
            $(this).css('position', 'relative');
            
            var delButton = $('<div/>').addClass('btn btn-danger')
                                       .append($('<span/>').addClass('glyphicon glyphicon-trash'))
                                       .on('click', function() {
                                           $(this).closest('.irEditor-wrapper').remove();
                                       });
            var editContainer = $('<aside/>').addClass('editButton')
                                            .append(delButton);
    
            $(this).wrap('<div/>')
                   .closest('div')
                   .addClass('irEditor-wrapper')
                   .css({'position': 'relative'})
                   .append(editContainer);
        });
    };
    var removeEditHandler = function() {
        $('.module', $editor).each(function() {
            $('> aside', $(this).closest('.irEditor-wrapper')).remove();
            $(this).unwrap();
        });
    };
    
    var initTextBlock = function() {
        $('.module.textBlock').each(function() {
            $(this).tinymce({
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
        });
    };
    var cleanupTextBlock = function() {
        $('.module.textBlock[id^="mce_"]').each(function() {
            $(this).tinymce().remove();
        });
    };
    
    var initCarousel = function() {
        $('.carousel .item').each(function() {
            var $item = $(this);

            var createControls = function(label, id) {
                var value = "";

                switch(id) {
                    case 'src': {
                        value = $('img', $item).attr(id) || '';
                        break;
                    }
                    case 'headline': {
                        value = $('.carousel-caption > h3', $item).text();
                        break;
                    }
                    case 'description': {
                        value = $('.carousel-caption > span', $item).text();
                        break;
                    }
                }

                return $('<div/>').addClass('form-group')
                                  .append($('<div/>').addClass('col-md-3 control-label')
                                                     .text(label))
                                  .append($('<div/>').addClass('col-md-9')
                                                     .append($('<input/>').addClass('form-control')
                                                                          .attr('id', id)
                                                                          .val(value)
                                                                          .on('keypress', function() {
                                                                              switch(id) {
                                                                                  case 'src': {
                                                                                      $('img', $item).attr(id, $(this).val());
                                                                                      break;
                                                                                  }
                                                                                  case 'headline': {
                                                                                      if($(this).val() !== '') {
                                                                                          if($('.carousel-caption > h3', $item).length === 0) {
                                                                                              $('.carousel-caption', $item).prepend($('<h3/>'));
                                                                                          }
                                                                                          $('.carousel-caption > h3', $item).text($(this).val());
                                                                                      }
                                                                                      else {
                                                                                          $('.carousel-caption > h3', $item).remove();
                                                                                      }
                                                                                      break;
                                                                                  }
                                                                                  case 'description': {
                                                                                      if($(this).val() !== '') {
                                                                                          if($('.carousel-caption > span', $item).length === 0) {
                                                                                              $('.carousel-caption', $item).append($('<span/>'));
                                                                                          }
                                                                                          $('.carousel-caption > span', $item).text($(this).val());
                                                                                      }
                                                                                      else {
                                                                                          $('.carousel-caption > span', $item).remove();
                                                                                      }
                                                                                      break;
                                                                                  }
                                                                              }
                                                                          })));
            };

            var $container = $('<aside/>').addClass('editControls widget')
                                          .append($('<fieldset/>').append($('<legend/>').text('Optionen'))
                                                                  .append(createControls('Bildpfad',     'src'))
                                                                  .append(createControls('Titel',        'alt'))
                                                                  .append(createControls('Überschrift',  'headline'))
                                                                  .append(createControls('Beschreibung', 'description')));

            $(this).append($container);
        });
    }
    var cleanupCarousel = function() {
        $('.carousel .item').each(function() {
            $item = $(this);
            $('aside.editControls', $item).remove();
        });
    }
    
    addEditHandler();
    initTextBlock();
    initCarousel();
};