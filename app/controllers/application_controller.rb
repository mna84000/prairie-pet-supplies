class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    customer_fields = %i[
      first_name
      last_name
      address
      city
      postal_code
      province_id
    ]

    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: customer_fields
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: customer_fields
    )
  end
end
