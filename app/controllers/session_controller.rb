class SessionController < ApplicationController
  def new
    session[:previous_url] = request.referrer
  end

  def create
    user = User.find_by :email => params[:email]
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:previous_url].nil?
        redirect_to root_path
      else
        if check_for_account_match user.id
          if (session[:previous_url].include? "users") || (session[:previous_url].include? "airlines")
            redirect_to root_path
          else
            redirect_to session[:previous_url]
          end
        else
          redirect_to login_path
        end
      end
    else
      flash[:error] = "Invalid username or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
