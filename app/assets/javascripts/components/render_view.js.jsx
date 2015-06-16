window.loadIngredientSuggestionsEditor = function(ingredients) {
  /* Define the Fluxxor store (above) */
  /* ... */
  
  /* Define the React components (above) */
  /* ... */
  
  /* Load the Fluxxor store and render React components to the page */
  fluxIngredientSuggestionsStore.init(ingredients);
  React.render(<IngredientSuggestionsEditor flux={fluxIngredientSuggestionsStore.flux} />, 
    document.getElementById('js-ingredient-suggestions-editor'));
}
