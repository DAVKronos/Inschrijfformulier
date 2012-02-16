jQuery.fn.center = function () {
  this.css("position","absolute");
  this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
  this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
  return this;
}

jQuery.fn.centerWidth = function () {
  this.css("position","absolute");
  this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
  this.css("top", ( this.height() /2 -20));
  return this;
}

$(document).ready( function(){
//  $("#entry_form").center();
//  $("#entry_image").centerWidth();
  $(window).resize(function(){
//    $("#entry_form").center();
//    $("#entry_image").centerWidth();
  });
  });
