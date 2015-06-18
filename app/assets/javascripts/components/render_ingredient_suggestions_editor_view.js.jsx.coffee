@loadIngredientSuggestionsEditor = (ingredients) ->
  fluxIngredientSuggestionsStore.init ingredients
  React.render `<IngredientSuggestionsEditor flux={fluxIngredientSuggestionsStore.flux} />`, document.getElementById('js-ingredient-suggestions-editor')
