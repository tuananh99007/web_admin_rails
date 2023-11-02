class Admin::ProductsController < Admin::AdminController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @products = Product.all.includes(:category)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    category_id = params[:product][:category_id].to_i # Lấy category_id từ params và chuyển thành số nguyên
    @product.category_id = category_id

    if @product.save
      redirect_to products_path, notice: 'Product created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.valid?
      if @product.update(product_params)
        # Lấy danh sách category_ids từ params và chuyển thành một mảng
        category_ids = params[:product][:category_id]
        category_ids = [] if category_ids.blank? # Đảm bảo có thể xử lý trường hợp không có category_id
        @product.update(category_id: category_ids.first) # Cập nhật trường category_id
        redirect_to products_path, notice: 'Product updated successfully.'
      else
        flash.now[:error] = 'Error'
        render :edit
      end
    else
      flash.now[:alert] = 'Validation failed. Please check the form and try again.'
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product deleted successfully.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, category_id: [])
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
