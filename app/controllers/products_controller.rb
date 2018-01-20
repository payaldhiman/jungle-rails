class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review= Review.new
    # puts "show some reviews, yo"
    # puts @product.reviews

  end

end
