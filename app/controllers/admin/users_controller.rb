class Admin::UsersController < AdminController
  load_and_authorize_resource

  def index
    @search = User.search params[:q]
    @users = @search.result.page_kimanari(params[:page])
      .per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @users.to_csv}
      format.xls
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end

  def new
  end

  def create
    if @user.save
      flash[:success] = t "messages.create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "messages.update_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
  end
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end
end
