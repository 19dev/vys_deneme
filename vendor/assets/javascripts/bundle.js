function vbox() {
    var this_id = $(this).attr("id");
    var div = "div#" + this_id;
    var item = $(div).css("display");
    item == "none" ? $(div).show() : $(div).hide();
}

$(function(){
    $('.vbox').mouseup(vbox);
    $('body').mousedown(function(){
        $('.LinkBoxArea').fadeOut(500);
    });
});


