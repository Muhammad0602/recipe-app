class RecipesController < ApplicationController
  # GET /recipes
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
    @recipe = Recipe.find(params[:id])
    @inventories = current_user.inventories
    @selected_inventory_id = params[:inventory_id] || @inventories.first&.id
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
    @inventory = Inventory.find(params[:inventory_id])
    recipe_foods = @recipe.recipe_foods
    inventory_foods = @inventory.inventory_foods.index_by(&:food_id)
    @missing_items = {}
    @total_price = 0
    recipe_foods.each do |recipe_food|
      food = Food.find(recipe_food.food_id)
      quantity_needed = recipe_food.quantity
      inventory_food = inventory_foods[food.id]
      next if inventory_food.present? && inventory_food.quantity >= quantity_needed
      missing_quantity = [quantity_needed - (inventory_food&.quantity || 0), 0].max
      price = food.price * missing_quantity
      @missing_items[food.name] = { quantity: missing_quantity, price: price }
      @total_price += price
    end
    @amount_of_food_to_buy = @missing_items.length
    render 'shopping_lists/index', locals: { amount_of_food_to_buy: @amount_of_food_to_buy, recipe: @recipe, total_value_of_food_needed: @total_price, inventory: @inventory }
  end  

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
