class RelationshipsController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]

  def follow
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
