###*
# This file provided by Facebook is for non-commercial testing and evaluation purposes only.
# Facebook reserves all rights not expressly granted.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###

@Comment = React.createClass
  render: ->
    # converter = new (Showdown.converter)
    # rawMarkup = converter.makeHtml(@props.children.toString(), sanitize: true)
    rawMarkup = @props.children.toString()
    `<div className="comment panel panel-default">
      <div className="panel-heading">
        <h3 className="panel-title">
          {this.props.author}
        </h3>
      </div>
      <div className="panel-body">
        <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
      </div>
    </div>`

@CommentBox = React.createClass
  loadCommentsFromServer: ->
    $.ajax
      url: @props.url
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState data: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return
  handleCommentSubmit: (comment) ->
    $.ajax
      url: @props.url
      dataType: 'json'
      type: 'POST'
      data: comment: comment
      success: ((data) ->
        comments = @state.data
        comments.push data
        @setState data: comments
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return
  getInitialState: ->
    { data: [] }
  componentDidMount: ->
    @loadCommentsFromServer()
    # setInterval(this.loadCommentsFromServer, this.props.pollInterval);
    return
  render: ->
    `<div className="commentBox">
       <h1>Comments</h1>
       <CommentList data={this.state.data} />
       <CommentForm onCommentSubmit={this.handleCommentSubmit} />
     </div>`

@CommentList = React.createClass
  render: ->
    # // key is a React-specific concept and is not mandatory for the
    #  // purpose of this tutorial. if you're curious, see more here:
    #  // http://facebook.github.io/react/docs/multiple-components.html#dynamic-children
    commentNodes = @props.data.map((comment, index) ->
      `<Comment author={comment.author} key={index}>
         {comment.text}
       </Comment>`
    )
    `<div className="commentList">
      {commentNodes}
     </div>`

@CommentForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    author = React.findDOMNode(@refs.author).value.trim()
    text = React.findDOMNode(@refs.text).value.trim()
    if !text or !author
      return
    @props.onCommentSubmit
      author: author
      text: text
    React.findDOMNode(@refs.author).value = ''
    React.findDOMNode(@refs.text).value = ''
    return
  render: ->
    `<div className="panel panel-default">
      <div className="panel-heading">Add a Note</div>
      <div className="panel-body">
        <form className="commentForm " onSubmit={this.handleSubmit}>
          <div className="form-group">
            <label className="control-label" forName="authorInput">Author</label>
            <input type="text" id="authorInput" className="form-control" placeholder="Your name" ref="author" />
          </div>
          <div className="form-group">
            <label className="control-label" forName="commentInput">Comment</label>
            <textarea className="form-control" id="commentInput" rows="3" placeholder="Say something..." ref="text" />
          </div>
          <input type="submit" className="btn btn-primary" value="Post" />
        </form>
      </div>
    </div>`
