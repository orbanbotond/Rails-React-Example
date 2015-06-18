window.fluxIngredientSuggestionsStore ||= {}

window.fluxIngredientSuggestionsStore.constants =
  UPDATE_INGREDIENT: 'UPDATE_INGREDIENT'
  DELETE_INGREDIENT: 'DELETE_INGREDIENT'

window.fluxIngredientSuggestionsStore.store = Fluxxor.createStore(
  initialize: (options) ->
    @ingredients = options.ingredients or []
    @bindActions fluxIngredientSuggestionsStore.constants.UPDATE_INGREDIENT, @onUpdateIngredient, fluxIngredientSuggestionsStore.constants.DELETE_INGREDIENT, @onDeleteIngredient
    return

  getState: ->
    { ingredients: @ingredients }

  onUpdateIngredient: (payload) ->
    payload.ingredient.item = payload.new_name
    @emit 'change'
    return

  onDeleteIngredient: (payload) ->
    @ingredients = @ingredients.filter (ingredient) ->
      ingredient.id != payload.ingredient.id

    @emit 'change'
    return
)

window.fluxIngredientSuggestionsStore.init = (ingredients) ->
  tempStore = IngredientSuggestionsStore: new (fluxIngredientSuggestionsStore.store)(ingredients: ingredients)
  fluxIngredientSuggestionsStore.flux = new (Fluxxor.Flux)(tempStore, fluxIngredientSuggestionsStore.actions)
  return
