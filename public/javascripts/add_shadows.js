function add_shadows() {
  var targets = [
    "div.card",
    ".entry-body-html pre",
    ".entry-body-html blockquote"
  ];
  jQuery(targets.join(', ')).dropShadow({
    left: 4,
    top: 4,
    opacity: 0.5
  });
}

jQuery(document).ready(function(){
    setTimeout('add_shadows()', 1000);
});
