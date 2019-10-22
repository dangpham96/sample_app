class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :load_user, except: %i(create new index)

  def index
    @users = User.order(:name).page(params[:page])
      .per Settings.index_user.item_user_paginate
  end

  def show
    @microposts = @user.microposts.newpost.page(params[:page])
      .per Settings.index_user.item_user_paginate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("send-mail-signup.tittle-send-mail4")
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t("edit-users-page.tittle-edit-user6")
      redirect_to @user
    else
      render :edit
    end
  end

   def destroy
    if @user.destroy
      flash[:success] = t("login-index-user.tittle-index-user4")
      redirect_to users_url
    else
      flash[:error] = t("login-index-user.tittle-index-user5")
      redirect_to root_path
    end
  end

  def following
    @title = t("follow_user.following")
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
      .per Settings.index_user.item_user_paginate
    render :show_follow
  end

  def followers
    @title = t("follow_user.followers")
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
      .per Settings.index_user.item_user_paginate
    render :show_follow
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t("login-page.tittle-login-7")
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t("users-page.tittle-user-1")
    redirect_to root_path
  end
end
