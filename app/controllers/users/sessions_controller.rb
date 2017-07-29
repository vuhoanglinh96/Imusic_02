class Users::SessionsController < Devise::SessionsController
  def create
    super
    flash.delete(:notice)
    flash[:success] = t ".success"
  end
end
