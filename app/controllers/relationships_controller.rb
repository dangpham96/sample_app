class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.present?
      current_user.follow @user
      respond_to :js
    else
      flash[:danger] = t("follow_user.follow_error")
      redirect_to root_path
    end
  end

  def destroy
    @user = Relationship.find_by(params[:id]).followed
    if @user.present?
      current_user.unfollow @user
      respond_to :js
    else
      flash[:danger] = t("follow_user.unfollow_error")
      redirect_to root_path
    end
  end
end
