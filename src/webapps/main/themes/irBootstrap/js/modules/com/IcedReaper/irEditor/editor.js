/**
 * this JavaScript files provites all logic for the page editor
 *
 * @depends /vendor/jquery/jquery-2.0.3.min.js
 * @depends /vendor/bootstrap/bootstrap.js
 * @depends /vendor/tinyMce/jquery.tinymce.min.js
 * @depends /vendor/tinyMce/tinymce.min.js
 * @author Icedreaper <Kevin.Lang@gmx.de>
 */
$(function() {
    $('form#irEditor').on('submit', function() {
        return false;
    });

    if($('.content.editable').length === 1) {
        var editor = new irEditor($('.content.editable'));
    }

    tinymce.init({
        selector: "textarea"
    });

});

var irEditor = function($editor) {
    this.initTextBlock = function() {
        $('.textBlock', $editor).on('click', function(e) {
            e.preventDefault();


        });
    }

    $('.module', $editor).each(function() {
        $(this).css('position', 'relative');

        var container = $('<aside/>').addClass('editButton');
        var editButton   = $('<div/>').addClass('btn btn-default').append($('<span/>').addClass('glyphicon glyphicon-pencil')).on('click', function() {
            if($(this).closest('.module').hasClass('textBlock')) {
                var $module = $(this).closest('.module');
                
                $('div.text', $module).tinymce({
                    theme: "modern",
                    plugins: [
                        ["advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker"],
                        ["searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking"],
                        ["save table contextmenu directionality emoticons template paste"]
                    ],
                    add_unload_trigger: false,
                    schema: "html5",
                    inline: true,
                    toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image     | print preview media",
                    statusbar: false
                });

                /*$('h1', $module).tinymce({
                    selector: "h1.edit",
                    theme: "modern",
                    add_unload_trigger: false,
                    schema: "html5",
                    inline: true,
                    toolbar: "undo redo",
                    statusbar: false
                });

                $('h4', $module).tinymce({
                    selector: "h1.edit",
                    theme: "modern",
                    add_unload_trigger: false,
                    schema: "html5",
                    inline: true,
                    toolbar: "undo redo",
                    statusbar: false
                });*/
            }
        });
        var deleteButton = $('<div/>').addClass('btn btn-danger').append($('<span/>').addClass('glyphicon glyphicon-trash').on('click', function() {
            $(this).offset('.module').remove();
        }));

        container.append(editButton).append(deleteButton);

        $(this).append(container);
    });
};