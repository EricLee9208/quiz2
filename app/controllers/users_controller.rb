class UsersController < ApplicationController


  def new

    if user_signed_in?
      redirect_to root_path
    else
    @user = User.new
    end

  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash.notice = "Signed up!"
      redirect_to root_path
    else
      render :new, status: 303
    end

  end



  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def find_user
    @user = User.find params[:id]
  end
  def password_user
    @user = User.find params[:user_id]
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless can?(:crud, @user)
    
  end
end
