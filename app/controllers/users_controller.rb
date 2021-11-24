class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if !prevent_relogin
      render "new"
    end
  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    password = params[:password]
    user = User.new({
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      role: "Customer",
    })

    if user.save
      Cart.create!({ user_id: user.id, total_price: 0.0 })
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
