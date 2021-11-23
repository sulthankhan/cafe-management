class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if !prevent_relogin
      render "index"
    end
  end
end
