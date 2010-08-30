jQuery(document).ready(function(){
  jQuery(".navigation.main-nav li > ul").parent().hoverIntent({
    over: function () {
      jQuery(this).find("ul").slideDown('fast');
    },
    out: function () {
      jQuery(this).find("ul").slideUp('slow');
    },
  });
});
