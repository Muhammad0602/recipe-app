class RecipesController < ApplicationController
  # GET /recipes
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
    @recipe = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    respond_to do |f|
      if @recipe.save
        f.html { redirect_to my_recipes_path, notice: 'Recipe was successfully created' }
      else
        f.html { render :new }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to my_recipes_path, notice: 'Recipe was successfully destroyed' }
    end
  end

  def my_recipes
    @recipes = current_user.recipes.includes(:user)
  end

  def public_recipes
    @recipes = Recipe.includes(:user).where(public: true)
  
    @shopping_lists = {}
    @recipes.each do |recipe|
      @shopping_lists[recipe.id] = generate_shopping_list(recipe)
    end
  end
  

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe
  end

  def shopping_list
    @recipe = Recipe.find(params[:id])
    @shopping_list, @total_items, @total_price = generate_shopping_list(@recipe)
    render 'shopping_lists/index'
  end

  def generate_shopping_list(recipe)
    recipe_foods = RecipeFood.where(recipe: recipe)

    shopping_list = {}
    total_items = 0
    total_price = 0

    recipe_foods.each do |recipe_food|
      food = Food.find(recipe_food.food_id)
      quantity = recipe_food.quantity
      measurement_unit = food.measurement_unit

      if shopping_list[food.name].nil?
        shopping_list[food.name] = { quantity: quantity, measurement_unit: measurement_unit, price: food.price * quantity, name: food.name }
      else
        shopping_list[food.name][:quantity] += quantity
        shopping_list[food.name][:price] += food.price * quantity
      end

      total_items += quantity
      total_price += food.price * quantity
    end

    return shopping_list, total_items, total_price
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
