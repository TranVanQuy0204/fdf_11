class Admin::CategoriesController < AdminController
  load_and_authorize_resource

  def index
    @search = Category.search params[:q]
    @categories = @search.result.page_kimanari(params[:page_kimanari])
      .per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @categories.to_csv}
      format.xls
    end
  end

def destroy
    @category = Category.find_by id: params[:id]
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "messages.create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    @category = Category.find_by id: params[:id]
    if @category.update_attributes category_params
      flash[:success] = t "messages.update_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by id: params[:id]
  end
  private
  def category_params
    params.require(:category).permit :name, :image, :description, :parent_code
  end
end
