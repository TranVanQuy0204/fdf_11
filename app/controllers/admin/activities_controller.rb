class Admin::ActivitiesController < AdminController
  def index
    @search = PublicActivity::Activity.search params[:q]
    @activities = @search.result.page_kimanari(params[:page]).per 20
  end
end
