class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.newpost.page(params[:page])
      .per Settings.index_user.item_user_paginate
  end

  def help; end

  def about; end

  def contact; end
end
