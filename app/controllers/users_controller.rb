class UsersController < ApplicationController
  before_action :check_for_admin, :only => [:index]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @tickets = (User.find params[:id]).tickets
  end

  def edit
    @user = User.find params[:id]
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
