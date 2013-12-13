$(function() {
    $('#newPosition input[name="newPosition"]').on('input', function() {
        if($.trim($(this).val()) !== '') {
            $('#newPositionToShow').show();
            
            $('#newPositionToShow input').val($(this).val()).find('[type="radio"]').prop('checked', true);
        }
        else {
            $('#newPositionToShow').hide();
            
            $('input[name="navigationToShow"][value="header"]').prop('checked', true);
        }
    });
    
    $('#newPositionToShow').hide();
});