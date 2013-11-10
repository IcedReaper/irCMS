<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" charset="utf-8" src="/themes/irBootstrap/js/vendor/jquery/jquery-2.0.3.min.js"></script>
        <script type="text/javascript" src="/themes/irBootstrap/min/vendor.tinyMce.jquery.tinymce.min.min.20131110094722.js" charset="utf-8"></script>
        <script type="text/javascript" src="/themes/irBootstrap/min/vendor.tinyMce.tinymce.min.min.20131110094732.js" charset="utf-8"></script>
    </head>
    <body>
        <div class="text">Dies ist ein Standardtext</div>

        <button>Make tinyMCE</button>

        <script type="text/javascript" charset="utf-8">
            $(function() {
                $('button').on('click', function() {
                    $('div.text').tinymce({
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

                    $(this).hide();
                });
            });
        </script>
    </body>
</html>