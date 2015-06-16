var fluxIngredientSuggestionsStore = {};
 
fluxIngredientSuggestionsStore.constants = {
  UPDATE_INGREDIENT: "UPDATE_INGREDIENT",
  DELETE_INGREDIENT: "DELETE_INGREDIENT",
};

fluxIngredientSuggestionsStore.store = Fluxxor.createStore({
  initialize: function(options) {
    /* We'll have ingredients */
    this.ingredients = options.ingredients || [];
    /* Those ingredients can be updated and deleted */
    this.bindActions(fluxIngredientSuggestionsStore.constants.UPDATE_INGREDIENT, this.onUpdateIngredient, fluxIngredientSuggestionsStore.constants.DELETE_INGREDIENT, this.onDeleteIngredient);
  },
  getState: function() {
    /* If someone asks the store what the ingredients are, show them */
    return {
      ingredients: this.ingredients,
    };
  },
  onUpdateIngredient: function(payload) {
    /* Update the model if an ingredient is renamed */
    payload.ingredient.item = payload.new_name;
    this.emit("change")
  },
  onDeleteIngredient: function(payload) {
    /* Update the model if an ingredient is deleted */
    this.ingredients = this.ingredients.filter(function(ingredient) {
      return ingredient.id != payload.ingredient.id
    });
    this.emit("change");
  }
});

fluxIngredientSuggestionsStore.actions = {
  updateIngredient: function(ingredient, new_name) {
    /* First, update the model by calling the function above */
    this.dispatch(fluxIngredientSuggestionsStore.constants.UPDATE_INGREDIENT, {
      ingredient: ingredient,
      new_name: new_name
    });
    /* Then, update the server and show a success message */
    $.ajax({
      type: "PUT",
      url: "/ingredient_suggestions/" + ingredient.id + ".json",
      data: { 
        ingredient_suggestion: {
          item: new_name        
        }
      },
      success: function() {
        $.growl.notice({
          title: "Ingredient suggestion updated",
        });
      },
      failure: function() {
        $.growl.error({
          title: "Error updating ingredient suggestion",
        });
      }
    });
  },
  deleteIngredient: function(ingredient) {
    /* First, update the model by calling the function above */
    this.dispatch(fluxIngredientSuggestionsStore.constants.DELETE_INGREDIENT, {
      ingredient: ingredient
    });
    /* Then, delete it on the server and show a success message */
    $.ajax({
      type: "DELETE",
      url: "/ingredient_suggestions/" + ingredient.id,
      success: function(data) {
        $.growl.notice({
          title: "Ingredient suggestion deleted",
        });
      }.bind(this),
      failure: function() {
        $.growl.error({
          title: "Error deleting ingredient suggestion",
        });
      }
    });
  }
};

fluxIngredientSuggestionsStore.init = function(ingredients) {
  var tempStore = {
    IngredientSuggestionsStore: new fluxIngredientSuggestionsStore.store({
      ingredients: ingredients
    })
  };
  fluxIngredientSuggestionsStore.flux = new Fluxxor.Flux(tempStore, fluxIngredientSuggestionsStore.actions);
}
