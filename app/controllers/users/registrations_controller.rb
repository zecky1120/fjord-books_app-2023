# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def show
    @user = User.find_by(id: params[:id])
  end

  protected


  def after_sign_up_path_for(_)
    "/users/#{current_user.id}"
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
