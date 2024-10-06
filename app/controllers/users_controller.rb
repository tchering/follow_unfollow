class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def index
    @users = User.all.includes(:addresses)
  end

  def new
    @user = User.new
    # Here we can either do this here or put it in after initialize
    @user.addresses.build
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, addresses_attributes: [:id, :country, :city, :_destroy])
  end

  # By including the id in addresse_attribute field for each address in the form, Rails can correctly identify existing addresses and update them instead of creating new ones. This ensures that the form behaves as expected when editing user addresses.

  def set_user
    @user = User.includes(:addresses).find(params[:id])
  end
end
