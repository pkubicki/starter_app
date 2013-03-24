class DashboardsController < ApplicationController
  skip_after_filter :verify_authorized

  def show
  end
end
