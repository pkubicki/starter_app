class ApplicationController < ActionController::Base
  protect_from_forgery
  responders :flash
  layout :current_layout
  before_filter :set_locale
  before_filter :require_login, except: [:not_authenticated] 

  # TODO: integration with one of available authorization solution, function added with yamled_acl in mind
  helper_method :allowed_to?
  def allowed_to?(*)
    true
  end

  protected

  def not_authenticated
    head :not_found
  end

  private
 
  def current_layout
    'application'
  end 

  def xlsx_filename(resource_class)
    I18n.transliterate(resource_class.model_name.human(count: 2)).downcase
  end

  # hack for passenger and tests
  def set_locale
    I18n.locale = I18n.default_locale
  end

end

