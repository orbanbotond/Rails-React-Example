$(document).on 'ready page:change', ->
  $content = $('#content')
  if $content.length > 0
    React.render `<CommentBox url="comments.json" pollInterval={2000} />`, document.getElementById('content')
  return
