class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[update destroy]
  before_action :set_recipe, only: %i[new create]

  def new
    @recipe_food = @recipe.recipe_foods.build
  end

  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to @recipe, notice: 'Recipe food was successfully created.'
    else
      render :new
    end
  end

  def modify
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to @recipe_food.recipe, notice: 'Recipe food was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe_food.destroy
    redirect_to @recipe_food.recipe, notice: 'Recipe food was successfully destroyed.'
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
