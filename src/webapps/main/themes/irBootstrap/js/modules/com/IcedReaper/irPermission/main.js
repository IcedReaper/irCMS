/**
 * @minified true
 */
$(function() {
    var checkForEmptyList = function($list) {
        $list = ! isNumeric($list) ? $list : $(this);
        
        if($('li', $list).length === 0) {
            $list.append($($('#dummyUser').html()));
        }
    };
    
    $('ul.list-group').each(checkForEmptyList)
                      .on({
                          'drop': function(e) {
                              e.preventDefault();
                              
                              $(this).find('li.dummy').remove();
                              var $element = $('#'+e.originalEvent.dataTransfer.getData("id"));
                              var origList = $element.closest('ul');
                              $(this).append($element);
                              
                              checkForEmptyList(origList);
                          }, 'dragover': function(e) {
                              e.preventDefault();
                          }
                      }).on({
                          'dragstart': function(e) {
                              e.originalEvent.dataTransfer.setData("id", $(this).attr('id'));
                          }
                      }, 'li');
    
    $('button#save').on('click', function() {
        $('ul.list-group').each(function() {
            
        });
    });
});