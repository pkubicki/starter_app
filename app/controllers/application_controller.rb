class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  responders :flash
  before_filter :authorize_action
  after_filter :verify_authorized, except: [:index, :destroy_multiple]
  rescue_from YamledAcl::AccessDenied, with: :access_denied
  
  private

  def access_denied
    raise YamledAcl::AccessDenied if logged_in?
    require_login
  end

  def not_authenticated
    redirect_to root_path, alert: t(:'flash.login_required')
  end 

  def xlsx_filename(resource_class)
    I18n.transliterate(resource_class.model_name.human(count: 2)).downcase
  end

end

