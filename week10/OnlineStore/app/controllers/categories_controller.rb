class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)

    if @category.save!
      render json: @category
    else 
      render json: @category.errors, status: 422
    end
  end

  def index
    render json: Category.all
  end

  def destroy
    @categories = Category.all
    @categories.find(params[:id]).destroy

    render json: @categories
  end

  def count
    @categories = Category.all

    render json: @categories.length
  end

  def show
    @categories = Category.all
    @category = @categories.find(params[:id])

    render json: @category
  end

  def edit
    @categories = Category.all
    @category = @categories.find(params[:id])

    if update!(@category)
      render json: @category
    else
      render json: @category.errors
    end
  end

  def range
    @categories = Category.all
    categories_to_show = @categories.where('id >= ?', params[:id])
    
    render json: categories_to_show
  end

  def range_count
    @categories = Category.all
    categories_to_show = @categories.where('id >= ?', params[:id])
    
    render json: categories_to_show.length
  end

  private

  def category_params
    params.permit(:name)
  end
end