class UsersController < ApplicationController
  before_action :check_for_admin, :only => [:index]
  before_action :check_for_login, :only => [:index, :show, :edit, :update]
  
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
    check_for_account_match params[:id]
    user = User.find params[:id]
    @tickets = user.tickets
  end

  def edit
    check_for_account_match params[:id]
    @user = User.find params[:id]
  end

  def update
    check_for_account_match params[:id]
    user = User.find params[:id]
    user.update user_params
    redirect_to user_path(user)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
