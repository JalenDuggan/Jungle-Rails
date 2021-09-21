class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: ENV['ADMIN_USR'], password: ENV['ADMIN_PASS']
  def show
    @products_count = Product.count
    @categories_count = Category.count
  end
end
