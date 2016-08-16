class Admin::ProductsController < AdminController
  def index
    @search = Product.search params[:q]
    @products = @search.result.page_kimanari(params[:page_kimanari])
      .per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @products.to_csv}
      format.xls
    end
  end

  def destroy
    @product = Product.find_by id: params[:id]
    if @product.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "messages.create_success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def update
    @product = Product.find_by id: params[:id]
    if @product.update_attributes product_params
      flash[:success] = t "messages.update_success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find_by id: params[:id]
  end

  private
  def product_params
    params.require(:product).permit :name, :image, :price, :total,
      :category_id, :description
  end
end
