jQuery(document).ready(function(){
  jQuery(".navigation.main-nav li > ul").parent().hover(function () {

    jQuery(this).find("ul").slideDown('fast').show();

    jQuery(this).hover(function() {}, function(){
      jQuery(this).find("ul").slideUp('slow');
    });
  });
});
