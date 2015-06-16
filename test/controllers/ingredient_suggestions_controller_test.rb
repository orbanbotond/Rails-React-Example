require 'test_helper'

class IngredientSuggestionsControllerTest < ActionController::TestCase
  setup do
    @ingredient_suggestion = ingredient_suggestions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredient_suggestions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredient_suggestion" do
    assert_difference('IngredientSuggestion.count') do
      post :create, ingredient_suggestion: { item: @ingredient_suggestion.item }
    end

    assert_redirected_to ingredient_suggestion_path(assigns(:ingredient_suggestion))
  end

  test "should show ingredient_suggestion" do
    get :show, id: @ingredient_suggestion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredient_suggestion
    assert_response :success
  end

  test "should update ingredient_suggestion" do
    patch :update, id: @ingredient_suggestion, ingredient_suggestion: { item: @ingredient_suggestion.item }
    assert_redirected_to ingredient_suggestion_path(assigns(:ingredient_suggestion))
  end

  test "should destroy ingredient_suggestion" do
    assert_difference('IngredientSuggestion.count', -1) do
      delete :destroy, id: @ingredient_suggestion
    end

    assert_redirected_to ingredient_suggestions_path
  end
end
