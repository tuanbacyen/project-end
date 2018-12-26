class ManagerUsersController < ApplicationController
  before_action :user_confirmed, :authenticate_user!
  before_action :can_show_list, only: [:index, :new, :create]
  before_action :load_all_users, only: :index
  before_action :load_this_user, only: :show
  before_action :new_user, only: :new
  before_action :get_user, only: [:destroy, :update, :edit]

  def show
    can_permission? @user if @user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index; end
  
  def new; end

  def create
    @user = User.new create_params
    setting_before_create
    if @user.permission_create? current_user
      semester_convert_date
      render :new
    elsif @user.save
      flash[:success] = "create success"
      redirect_to manager_users_path
    else
      semester_convert_date
      render :new
    end
  end

  def edit; end

  def update
    if user_has_edit && @user.update_attributes(current_user.it_me?(@user) ? update_params.except(:role) : update_params)
      @user.update_gender if params[:user][:gender] == "nil"
      flash[:success] = t "update_success"
      redirect_to manager_users_path
    else
      @user.add_error_permission
      semester_convert_date
      render :edit
    end
  end

  def destroy
    if !@user.admin_than_you? current_user
      flash[:danger] = "ban khong co quyen"
    elsif @user.check_present?
      flash[:danger] = "mon hoc co gia tri con"
    elsif @user.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to manager_users_path
  end

  private
  def check_it_me
    unless current_user.it_me? @user
      flash[:danger] = "Ban khong co quyen"
      redirect_to root_path
    end
  end

  def load_all_users
    @users = User.load_all_users?.user_confirmed true
  end

  def new_user
    @user = User.new
    semester_convert_date
  end

  def create_params
    params[:user][:birth] = convert_date params[:user][:birth]
    params.require(:user).permit :email, :phone, :name, :identity_card, :gender, :address, :birth, :role, :avatar, :working
  end

  def update_params
    params[:user][:birth] = convert_date params[:user][:birth]
    params.require(:user).permit :name, :identity_card, :gender, :address, :birth, :role, :avatar, :working
  end

  def get_user
    @user = User.find_by(id: params[:id])
    if @user
      semester_convert_date
      return
    end
    flash[:danger] = "user not found"
    redirect_to manager_users_path
  end

  def load_this_user
    @user = User.find_by(id: params[:id])
  end

  def semester_convert_date
    @user.birth = convert_date_to_local @user.birth
  end

  def setting_before_create
    @user.password = @user.default_password
    @user.confirmed = true
    @user.gender = nil if params[:user][:gender] == "nil"
  end

  def user_has_edit
    @user.has_permission_edit? current_user, convert_role(params[:user][:role])
  end
end
