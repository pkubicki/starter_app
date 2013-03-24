class UsersController < ApplicationController
  respond_to :html

  def index
    @q = User.search(params[:q])
    @users = policy_scope(@q.result.page(params[:page]))
    respond_to do |format|
      format.html
      format.xlsx {render xlsx: "index", filename: xlsx_filename(User)}
    end
  end

  def show
    @user = User.find(params[:id])
    authorize(@user)
    respond_with(@user)
  end

  def new
    @user = User.new
    authorize(@user)
    respond_with(@user)
  end

  def edit
    @user = User.find(params[:id])
    authorize(@user)
    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    authorize(@user)
    @user.save
    respond_with(@user)
  end

  def update
    @user = User.find(params[:id])
    authorize(@user)
    @user.update_attributes(params[:user])
    respond_with(@user)
  end

  def destroy
    @user = User.find(params[:id])
    authorize(@user)
    @user.destroy
    respond_with(@user)
  end

  def destroy_multiple
    User.where(id: params[:ids]).each do |user|  
      user.destroy if policy(user).destroy?
    end if params[:ids]
    redirect_to(users_path, notice: t(:'flash.actions.destroy_multiple.notice'))
  end
end
