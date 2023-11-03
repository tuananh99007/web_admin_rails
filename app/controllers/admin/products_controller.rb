class Admin::ProductsController < Admin::AdminController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :find_category, only: [:new, :edit]

  def index
    @products = Product.page(params[:page]).per(Settings.products.per_page)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product created successfully."
    else
      flash[:alert] = "Failed to save Product. Please try again."
    end
    redirect_to new_admin_product_path
  end

  def edit
  end

  def update
    category_id = params[:product][:category_id]
    @product.category_id = category_id
    if @product.update(product_params)
      flash[:notice] = "Product updated successfully."
    else
      flash[:alert] = "Failed to update product. Please try again."
    end
    redirect_to edit_admin_product_path
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Product delete successfully."
    else
      flash[:alert] = "Failed to delete product."
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def find_category
    @categories = Category.all
  end
end
