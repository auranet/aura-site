// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

preview_markdown = function () {
  var markdown = $('entry_body_markdown').getValue();
  if (markdown.length) {
    new Ajax.Request('/entries/markdown_preview', {
      parameters: {
        markdown: markdown
      },
      onCreate: function () {
        $('content-preview').update(
          '<div style="background: black; color: white; padding: 10px;">' +
            'Loading <img src="/hobothemes/aura/images/spinner.gif" />' +
          '</div>'
        );
      },
      onSuccess: function (transport) {
        $('content-preview').update(transport.responseText);
      }
    });
  }
  else {
    $('content-preview').update($('entry_body_html').getValue());
  }
}
