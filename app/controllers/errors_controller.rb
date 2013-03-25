class ErrorsController < ApplicationController
  skip_after_filter :verify_authorized

  def not_found
    render :status => 404
  end
 
  def unacceptable
    render :status => 422
  end
 
  def interal_error
    render :status => 500
  end
 
end

