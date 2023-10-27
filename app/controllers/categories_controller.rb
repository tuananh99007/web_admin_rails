class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @categories = Category.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @category = Category.new
  end

def create
  @category = Category.new(category_params)
  if @category.save
    redirect_to categories_path, notice: 'Category created successfully.'
  else
    flash[:alert] = 'Failed to save category. Please try again.'
    redirect_to new
  end
end


  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'Category deleted successfully.'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
