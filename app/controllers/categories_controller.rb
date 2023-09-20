class CategoriesController < ApplicationController

  def show
    ## raise "here" to throw an error - whatever typed in is displayed as an error, a natural breakpoint 
    @category = Category.find(params[:id])
    ## raise.@category.inspect - safely call on any object which turns into dev friendly string for inspection 
    @products = @category.products.order(created_at: :desc)
  end

end
