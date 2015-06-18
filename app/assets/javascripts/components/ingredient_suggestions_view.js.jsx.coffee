@IngredientSuggestionsEditor = React.createClass
  mixins: [
    Fluxxor.FluxMixin(React)
    Fluxxor.StoreWatchMixin('IngredientSuggestionsStore')
  ]
  getStateFromFlux: ->
    flux = @getFlux()
    { ingredients: flux.store('IngredientSuggestionsStore').getState().ingredients }
  render: ->
    props = @props
    ingredients = @state.ingredients.map (ingredient) ->
      `<IngredientSuggestion ingredient={ingredient} key={ingredient.id} flux={props.flux} />`

    `<div>
      {ingredients}
    </div>`

IngredientSuggestion = React.createClass
  mixins: [ Fluxxor.FluxMixin(React) ]
  getInitialState: ->
    {
      changed: false
      updated: false
    }
  render: ->
    `<div>
      <a href="#" onClick={this.handleDelete}><i className="fa fa-times"></i></a> 
      <input onChange={this.handleChange} ref="ingredient" defaultValue={this.props.ingredient.item}/>
      {
        this.state.changed ?
        <span>
          <a href="#" onClick={this.handleUpdate}>Update</a>
          <a href="#" onClick={this.handleCancelChange}>Cancel</a>
        </span>
      :
        ""
      }
    </div>`

  handleChange: ->
    if $(@refs.ingredient.getDOMNode()).val() != @props.ingredient.item
      @setState changed: true
    else
      @setState changed: false
    return

  handleUpdate: (e) ->
    e.preventDefault()
    @getFlux().actions.updateIngredient @props.ingredient, $(@refs.ingredient.getDOMNode()).val()
    @setState
      changed: false
      updated: true
    return

  handleDelete: (e) ->
    e.preventDefault()
    if confirm('Delete ' + @props.ingredient.item + '?')
      @getFlux().actions.deleteIngredient @props.ingredient
    return

  handleCancelChange: (e) ->
    e.preventDefault()
    $(@refs.ingredient.getDOMNode()).val @props.ingredient.item
    @setState changed: false
    return
