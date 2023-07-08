class InventoryFoodsController < ApplicationController
  before_action :set_inventory
  before_action :set_inventory_food, only: %i[show destroy update]

  def index
    @inventory_foods = @inventory.inventory_foods
    @inventory_food = @inventory.inventory_foods.new
    @foods = Food.all
  end

  def show
    if params[:id] == 'new'
      @inventory_food = @inventory.inventory_foods.build
      @foods = Food.all
      render :new
    else
      @food = @inventory_food.food
    end
  end

  def create
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)

    if @inventory_food.save
      redirect_to inventory_path(@inventory), notice: 'Inventory food was successfully added.'
    else
      @inventory_foods = @inventory.inventory_foods
      @foods = Food.all
      render :index
    end
  end

  def destroy
    @inventory_food.destroy
    redirect_to inventory_inventory_foods_url(@inventory), notice: 'Inventory food was successfully removed.'
  end

  def update
    if @inventory_food.update(inventory_food_params)
      redirect_to inventory_inventory_foods_url(@inventory), notice: 'Inventory food was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_inventory
    @inventory = current_user.inventories.find(params[:inventory_id])
  end

  def set_inventory_food
    return if params[:id] == 'new'

    @inventory_food = @inventory.inventory_foods.find(params[:id])
  end

  def inventory_food_params
    params.require(:inventory_food).permit(:quantity, :food_id, :inventory_id)
  end
end
