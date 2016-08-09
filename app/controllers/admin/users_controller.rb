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
end
