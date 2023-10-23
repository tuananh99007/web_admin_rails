class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

def create
  @category = Category.new(category_params)

  if @category.valid?
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      flash[:alert] = 'Failed to save category. Please try again.'
      redirect_to new
    end
  else
    flash[:alert] = "Validation failed. Please check the form and try again."
    redirect_to new
  end
end


  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category deleted successfully.'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
