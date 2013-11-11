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
            removeTinyMce();
            
            // build
            $('input[name="content"]').val(buildSkeleton());
            
            // restore
            addEditHandler();
            initTextBlock();
        
            return true;
        } 
        catch (error) {
            console.log(error);
        
            return false;
        }
    });

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
    var removeTinyMce = function() {
        $('.module[id^="mce_"]').each(function() {
            $(this).tinymce().remove();
        });
    }
    
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
                
                if($(this).children().length > 0 && ! lastElement) {
                    skeletonNode[index].modules = buildSubSkeleton($(this).children());
                }
            });
            
            return skeletonNode;
        }
        
        var skeleton = buildSubSkeleton($('.content.editable'));
        return JSON.stringify(skeleton[0].modules).replace(/\\n/gi, '');
    };
    
    addEditHandler();
    initTextBlock();
};