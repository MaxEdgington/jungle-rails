class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_SECRET_KEY']
  def show
     @counted_product = Product.count
     @counted_category = Category.count
  end
end
