$(function() {
    var setFooterToBottom = function() {
        if($(window).height() > ($('body > header').height() + $('body > .container').height() + $('body > footer > nav').height() + 30)) {
            $('.navbar-static-bottom').removeClass('navbar-static-bottom').addClass('navbar-fixed-bottom');
        }
        else {
            $('.navbar-fixed-bottom').removeClass('navbar-fixed-bottom').addClass('navbar-static-bottom');
        }
    };
    $(window).on('resize', setFooterToBottom);

    setFooterToBottom();
});

function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
};