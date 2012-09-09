class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication

  protected

  def after_sign_up_path_for(resource)
    users_path
  end

  def new
    super
  end
end