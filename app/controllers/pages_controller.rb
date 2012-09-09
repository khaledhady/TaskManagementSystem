class PagesController < ApplicationController
  def redirect_to_sign_in
    if signed_in?.blank?
      redirect_to new_user_session_path
    end
  end
end