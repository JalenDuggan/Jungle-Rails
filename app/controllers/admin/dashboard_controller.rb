class Admin::DashboardController < ApplicationController
<<<<<<< HEAD
  # http_basic_authenticate_with name: ENV['ADMIN_USR'], password: ENV['ADMIN_PASS']
=======
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD']
>>>>>>> fix/admin-basic-auth
  def show
    @products_count = Product.count
    @categories_count = Category.count
  end
end
