class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
  	redirect_to root_path, notice: "This page doesn't exist."
  end

# protected

#   def configure_permitted_parameters
#   	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username,:mobile])
#   end
# end

# class ApplicationController < ActionController::Base
#   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :username, :mobile, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
