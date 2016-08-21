class ActivitiesController < ApplicationController

  def index
    @search_activity = PublicActivity::Activity.search params[:q]
    @activities = @search_activity.result
      .where(owner_id: current_user.id, owner_type: User.name)
      .page_kimanari(params[:page]).per 20
  end
end
