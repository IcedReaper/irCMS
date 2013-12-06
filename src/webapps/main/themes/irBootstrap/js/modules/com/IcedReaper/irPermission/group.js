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
    
    $('button#save').closest('form').on('submit', function() {
        var ruleData = [];
        $('ul.list-group').each(function(index) {
            ruleData[index] = {
                'roleName': $(this).attr('data-roleName'),
                'user':     $(this).find('li')
                                   .map(function() {
                                       return $(this).attr('data-userId')
                                   })
                                   .get()
            };
        });
        
        $('#newRoleStruct').val(JSON.stringify(ruleData).replace(/\\n/gi, ''));
        
        return true;
    });
});