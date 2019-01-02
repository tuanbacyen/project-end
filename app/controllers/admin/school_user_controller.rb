class Admin::SchoolUserController < ApplicationController
  load_and_authorize_resource

  before_action :get_user, only: [:index, :new, :create, :destroy]
  before_action :get_school_user, only: :destroy

  def index
    @school_user = @user.school_users
  end

  def new
    @school_user = SchoolUser.new
  end

  def create
    @school_user.user_id = @user.id
    if @school_user.save
      flash[:success] = t "create_success"
      redirect_to admin_user_school_user_index_path
    else
      render :new
    end
  end

  def destroy
    if @school_user.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to admin_user_school_user_index_path
  end

  private

  def get_user
    @user = User.find_by(id: params[:user_id])
    return if @user
    flash[:danger] = "user_not_found"
    redirect_to admin_users_path
  end

  def get_school_user
    redirect_to admin_user_school_user_index_path unless @school_user = SchoolUser.find_by(id: params[:id])
  end

  def school_user_params
    params.require(:school_user).permit(:school_id, :user_id) if params[:school_user]
  end
end
