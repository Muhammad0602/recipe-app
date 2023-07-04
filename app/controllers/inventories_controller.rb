class InventoriesController < ApplicationController
    before_action :set_inventory, only: [:show, :destroy]
    before_action :require_owner, only: [:show, :destroy]
  
    def index
      @inventories = current_user.inventories
    end
  
    def show
        @inventory = current_user.inventories.find(params[:id])
      
        @inventory_foods = @inventory.inventory_foods
      
        @total_food_items = @inventory_foods.sum(:quantity)
        @total_price = @inventory_foods.joins(:food).sum('foods.price * inventory_foods.quantity')
      end
  
    def new
      @inventory = current_user.inventories.build
    end
  
    def create
      @inventory = current_user.inventories.build(inventory_params)
      if @inventory.save
        redirect_to @inventory, notice: 'Inventory was successfully created.'
      else
        render :new
      end
    end
  
    def destroy
      @inventory.destroy
      redirect_to inventories_url, notice: 'Inventory was successfully deleted.'
    end
  
    private
  
    def set_inventory
      @inventory = current_user.inventories.find(params[:id])
    end
  
    def require_owner
      unless @inventory.user == current_user
        redirect_to inventories_url, alert: 'You are not authorized to perform this action.'
      end
    end
  
    def inventory_params
      params.require(:inventory).permit(:name)
    end
end
  