class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname])
  end
  def after_sign_in_path_for(resource)
   courses_path || stored_location_for(resource)
  end
  def after_sign_out_path_for(resource_or_scope)
   root_path  
  end

end
