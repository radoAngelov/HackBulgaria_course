class ProductsController < ApplicationController
    def create
    @product = Product.new(product_params)

    if @product.save!
      render json: @product
    else 
      render json: @product.errors, status: 422
    end
  end

  def index
    render json: Product.all
  end

  def destroy
    @products = Product.all
    @products.find(params[:id]).destroy

    render json: @products
  end

  def count
    @products = Product.all

    render json: @products.length
  end

  def show
    @products = Product.all
    @product = @products.find(params[:id])

    render json: @product
  end

  def edit
    @products = Product.all
    @product = @products.find(params[:id])

    if update!(@product)
      render json: @product
    else
      render json: @product.errors
    end
  end

  def range
    @products = Product.all
    products_to_show = @products.where('id >= ?', params[:id])
    
    render json: products_to_show
  end

  def range_count
    @products = Product.all
    products_to_show = @products.where('id >= ?', params[:id])
    
    render json: products_to_show.length
  end

  private

  def category_params
    params.permit(:price, :quantity, :brand_id, :category_id)
  end
end