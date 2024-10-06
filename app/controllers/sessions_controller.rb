class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      login(@user)
      flash[:notice] = "You have logged in"
      redirect_to user_path(@user), status: :see_other
    else
      message = "Email or Password incorrect"
      flash[:alert] = message
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
    logout
    redirect_to root_path
  end
end
