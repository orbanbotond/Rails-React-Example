window.fluxIngredientSuggestionsStore ||= {}

window.fluxIngredientSuggestionsStore.actions =
  updateIngredient: (ingredient, new_name) ->
    $.ajax
      type: 'PUT'
      url: '/ingredient_suggestions/' + ingredient.id + '.json'
      data: ingredient_suggestion: item: new_name
      success: ->
        $.growl.notice title: 'Ingredient suggestion updated'
        @dispatch fluxIngredientSuggestionsStore.constants.UPDATE_INGREDIENT,
          ingredient: ingredient
          new_name: new_name

        return
      failure: ->
        $.growl.error title: 'Error updating ingredient suggestion'
        return
    return

  deleteIngredient: (ingredient) ->
    $.ajax
      type: 'DELETE'
      url: '/ingredient_suggestions/' + ingredient.id
      success: ((data) ->
        @dispatch fluxIngredientSuggestionsStore.constants.DELETE_INGREDIENT, ingredient: ingredient
        $.growl.notice title: 'Ingredient suggestion deleted'
        return
      ).bind(this)
      failure: ->
        $.growl.error title: 'Error deleting ingredient suggestion'
        return
    return
