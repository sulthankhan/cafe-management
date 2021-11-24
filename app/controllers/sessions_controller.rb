class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if !prevent_relogin
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to menus_path
    else
      flash[:error] = "Your email/password is wrong!"
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
