var IngredientSuggestionsEditor = React.createClass({
  /* Update this component when the Fluxxor store is updated */
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("IngredientSuggestionsStore")],
  /* Get the ingredients list from the store */
  getStateFromFlux: function() {
    var flux = this.getFlux();
    return {
      ingredients: flux.store("IngredientSuggestionsStore").getState().ingredients
    };
  },
  /* Show each ingredient when the IngredientSuggestion component */
  render: function() {
    var props = this.props;
    var ingredients = this.state.ingredients.map(function (ingredient) {
      return <IngredientSuggestion ingredient={ingredient} key={ingredient.id} flux={props.flux} />
    });
    return (        
      <div>
        {ingredients}
      </div>
    );
  }
});

var IngredientSuggestion = React.createClass({
  /* We need this mixin since we are calling Flux store actions from this component */
  mixins: [Fluxxor.FluxMixin(React)],
  /* We'll track two things for each ingredient, whether the user has changed its name and whether they have saved the update to the server. */
  getInitialState: function() {
    return {changed: false, updated: false};
  },
  render: function() {
    return (
      <div>
        <a href="#" onClick={this.handleDelete}><i className="fa fa-times"></i></a> 
        <input onChange={this.handleChange} ref="ingredient" defaultValue={this.props.ingredient.item}/>
        {/* Show the Update and Cancel buttons only if the user has changed the ingredient name */
          this.state.changed ?
          <span>
            <a href="#" onClick={this.handleUpdate}>Update</a>
            <a href="#" onClick={this.handleCancelChange}>Cancel</a>
          </span>
        :
          ""
        }
      </div>
    )
  },
  handleChange: function() {
    /* If the user changed the ingredient name, set the 'changed' state to true */
    if ($(this.refs.ingredient.getDOMNode()).val() != this.props.ingredient.item) {
      this.setState({changed: true});
    } else {
      this.setState({changed: false});
    }
  },
  handleUpdate: function(e) {
    /* Update the ingredient name in the Fluxxor store */
    e.preventDefault();
    this.getFlux().actions.updateIngredient(this.props.ingredient, $(this.refs.ingredient.getDOMNode()).val());
    this.setState({changed: false, updated: true});
  },
  handleDelete: function(e) {
    /* Delete the ingredient from the Fluxxor store */
    e.preventDefault();
    if (confirm("Delete " + this.props.ingredient.item + "?")) {
      this.getFlux().actions.deleteIngredient(this.props.ingredient);
    }
  },
  handleCancelChange: function(e) {
    e.preventDefault();
    $(this.refs.ingredient.getDOMNode()).val(this.props.ingredient.item);
    this.setState({changed: false});
  }
});
