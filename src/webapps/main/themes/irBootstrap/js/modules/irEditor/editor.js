$(function() {
    $('form#irEditor').on('submit', function() {
        $('input[name="content"]').val($('form#irEditor .content').html());

        return true;
    });
});