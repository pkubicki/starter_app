class Users::SessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
  end

  def create
    respond_to do |format|
      if login(params[:login], params[:password])
        format.html {redirect_back_or_to root_path, notice: t(:'flash.users.sessions.create.notice')}
      else
        flash.now[:alert] = t(:'flash.users.sessions.create.alert')
        format.html {render action: 'new'}
      end
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: t(:'flash.users.sessions.destroy.notice'))
  end

end

