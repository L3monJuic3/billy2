class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[create update destroy prepared! served!]

  def show
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    # if @order_item.save
    #   redirect_to new_restaurant_menu_path(@restaurant)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def update
  end

  def destroy
    @order_item.destroy
    # redirect_to host_restaurant_path(@order_item.restaurant), status: :see_other
  end

  def prepared!
    @order_item.update(is_prepared: true)
    redirect_to kitchen_path(@order_item.restaurant)
  end

  def served!
    @order_item.update(is_served: true)
    redirect_to restaurant_table_table_orders_path(@order_item.restaurant, @order_item.table)
  end

  def bool_to_ready(value)
    "<span class='bg-red-500 px-3 py-2 text-white text-sm rounded-lg'>Ready</span>".html_safe if value
  end

  private

  def order_item_params
    params.require(:order_item).permit(:estimated_serving_time, :note)
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end
end
