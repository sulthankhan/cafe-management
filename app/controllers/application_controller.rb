class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  def prevent_relogin
    if current_user
      redirect_to menus_path
    else
      nil
    end
  end

  def ensure_admin_logged_in
    unless @current_user.role == "Admin"
      redirect_to menus_path
    end
  end

  def ensure_user_logged_in
    unless current_user
      # halt tht request cycle
      redirect_to "/"
    else
      @cart = Cart.find_by(user_id: @current_user.id)
    end
  end

  def current_user
    # memoization
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
