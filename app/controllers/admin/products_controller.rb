class Admin::ProductsController < Admin::AdminController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :find_category, only: [:new, :edit]

  def page_number
    # params là một biến chứa thông tin được gửi từ trình duyệt hoặc từ một yêu cầu HTTP
    # params[:page] đang lấy giá trị của tham số :page từ đối tượng params
    # .presence: Kiểm tra xem params[:page] có tồn tại và khác nil hay không.
    # .to_i: Chuyển đổi giá trị của params[:page] thành một số nguyên. Nếu params[:page] không tồn tại hoặc là nil, thì .to_i sẽ trả về 0.
    page = params[:page].presence.to_i
    # page > 0 ? page - 1 : 0: Sau đó, nó kiểm tra xem giá trị của page có lớn hơn 0 hay không. Nếu có, nó trả về giá trị page - 1, tức là giảm giá trị của trang đi 1.
    page > 0 ? page - 1 : 0
  end

  def index
    per_page = Settings.products.per_page
    #  limit xác định số lượng sản phẩm cần lấy (là per_page)
    #  offset xác định vị trí bắt đầu lấy, dựa trên số trang hiện tại (được tính toán thông qua page_number)
    @products = Product.limit(per_page).offset(page_number * per_page)
    # Product.count là số lượng bản ghi trong bảng Product.
    # to_f: Chuyển đổi số lượng bản ghi thành số thực (float).đảm bảo rằng kết quả của phép chia sẽ là một số thực để tránh việc mất thông tin sau dấu thập phân trong kết quả của phép chia.
    # / per_page: Chia số lượng bản ghi cho số lượng bản ghi mỗi trang (per_page) => tính số lượng trang cần hiển thị.
    # .ceil: Làm tròn lên đến số nguyên gần nhất. Kết quả của phép chia có thể là một số thực, nhưng số trang không thể là một số thực, không thể có 2.5 trang
    @total_pages = (Product.count.to_f / per_page).ceil
    @current_page = page_number + 1
    @products_pt = Product.where("name LIKE ?", "%pt%").limit(3)
  end

  def html
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
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

  def delegate_product_attribute(attribute)
    @product.send(attribute)
  end

  helper_method :delegate_product_attribute
end
