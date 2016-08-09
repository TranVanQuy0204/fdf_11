class Admin::UsersController < AdminController
  def index
    @search = User.search params[:q]
    @users = @search.result.page_kimanari(params[:page_kimanari])
      .per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @users.to_csv}
      format.xls
    end
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "messages.create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "messages.update_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end
end
