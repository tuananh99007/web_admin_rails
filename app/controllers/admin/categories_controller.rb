class Admin::CategoriesController < Admin::AdminController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.page(params[:page]).per(Settings.default.per_page)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "Category created successfully."
    else
      flash[:alert] = "Failed to save category. Please try again."
      redirect_to new_admin_category_path
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @category.products.each do |product|
      product.destroy
    end
    if @category.destroy
      redirect_to admin_categories_path, notice: "Category deleted successfully."
    else
      redirect_to admin_categories_path, alert: "Failed to delete category."
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
