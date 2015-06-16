class IngredientSuggestionsController < ApplicationController
  before_action :set_ingredient_suggestion, only: [:show, :edit, :update, :destroy]

  # GET /ingredient_suggestions
  # GET /ingredient_suggestions.json
  def index
    @ingredient_suggestions = IngredientSuggestion.all.order('item ASC')
    @ingredients = @ingredient_suggestions.select(:id, :item)
  end

  # GET /ingredient_suggestions/1
  # GET /ingredient_suggestions/1.json
  def show
  end

  # GET /ingredient_suggestions/new
  def new
    @ingredient_suggestion = IngredientSuggestion.new
  end

  # GET /ingredient_suggestions/1/edit
  def edit
  end

  # POST /ingredient_suggestions
  # POST /ingredient_suggestions.json
  def create
    @ingredient_suggestion = IngredientSuggestion.new(ingredient_suggestion_params)

    respond_to do |format|
      if @ingredient_suggestion.save
        format.html { redirect_to @ingredient_suggestion, notice: 'Ingredient suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient_suggestion }
      else
        format.html { render :new }
        format.json { render json: @ingredient_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredient_suggestions/1
  # PATCH/PUT /ingredient_suggestions/1.json
  def update
    respond_to do |format|
      if @ingredient_suggestion.update(ingredient_suggestion_params)
        format.html { redirect_to @ingredient_suggestion, notice: 'Ingredient suggestion was successfully updated.' }
        format.json do
          render :nothing => true, :status => 200
          # render :show, status: :ok, location: @ingredient_suggestion
        end
      else
        format.html { render :edit }
        format.json { render json: @ingredient_suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_suggestions/1
  # DELETE /ingredient_suggestions/1.json
  def destroy
    @ingredient_suggestion.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_suggestions_url, notice: 'Ingredient suggestion was successfully destroyed.' }
      format.json do
        # head :no_content
        render :nothing => true, :status => 200
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_suggestion
      @ingredient_suggestion = IngredientSuggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_suggestion_params
      params.require(:ingredient_suggestion).permit(:item)
    end
end
