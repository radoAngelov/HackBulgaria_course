class BrandsController < ApplicationController
  def create
    @brand = Brand.new(brand_params)

    if @brand.save!
      render json: @brand
    else
      render json: @brand.errors, status: 422
    end
  end

  def index
    render json: Brand.all
  end

  def destroy
    @brands = Brand.all
    @brands.find(params[:id]).destroy

    render json: @brands
  end

  def count
    @brands = Brand.all

    render json: @brands.length
  end

  def show
    @brands = Brand.all
    @brand = @brands.find(params[:id])

    render json: @brand
  end

  def edit
    @brands = Brand.all
    @brand = @brands.find(params[:id])

    if update!(@brand)
      render json: @brand
    else
      render json: @brand.errors
    end
  end

  def range
    @brands = Brand.all
    brands_to_show = @brands.where('id >= ?', params[:id])
    
    render json: brands_to_show
  end

  def range_count
    @brands = Brand.all
    brands_to_show = @brands.where('id >= ?', params[:id])

    render json: brands_to_show.length
  end

  private

  def brand_params
    params.permit(:name, :description)
  end
end