class Admin::CategoriesController < Admin::AdminController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.page(params[:page]).per(Settings.categories.per_page)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully."
    else
      flash[:alert] = "Failed to save category. Please try again."
    end
    redirect_to new_admin_category_path
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated successfully."
    else
      flash[:alert] = "Failed to update category. Please try again."
    end
    redirect_to edit_admin_category_path
  end

  def destroy
    if @category.destroy
      flash[:notice] = "The category and corresponding product have been successfully deleted."
    else
      flash[:alert] = "Failed to delete category."
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
