class ApplicationController < ActionController::Base
  private

  def after_sign_out_path_for(_resource_or_scope)
    new_admin_user_session_path
  end
end