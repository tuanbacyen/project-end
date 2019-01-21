class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_users, only: :index
  before_action :load_all_confirmed_users, only: :index_confirm
  before_action :load_user, only: :show
  before_action :new_user, only: :new
  before_action :get_user, only: [:destroy, :update, :edit]
  before_action :get_user_confirm, only: [:confirm, :new_confirm]

  rescue_from CanCan::AccessDenied do
    flash[:danger] = "ban khong co quyen"
    if current_user&.admin?
      redirect_to admin_users_path
    else
      redirect_to root_path
    end
  end

  def show
    repond
  end

  def index; end

  def index_confirm; end

  def new_confirm; end

  def confirm
    @student = Student.find_by id: params[:student_confirmed]
    if @student
      @user.update confirmed: true
      su = @user.school_users.build
      su.school_id = params[:school_confirmed]
      su.save
      @student.update user_id: @user.id
      @user.confirmed_descriptions.destroy_all
      flash[:success] = "confirmed success"
    else
      flash[:danger] = "Has a error"
    end
    redirect_to admin_users_confirmed_path
  end

  def new; end

  def create
    @user = User.new create_params
    setting_before_create
    if @user.permission_create? current_user
      semester_convert_date
      render :new
    elsif @user.save
      flash[:success] = "create success"
      redirect_to new_admin_user_school_user_path @user
    else
      semester_convert_date
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes current_user.it_me?(@user) ? update_params.except(:role) : update_params
      @user.update_gender if params[:user][:gender] == "nil"
      flash[:success] = t "update_success"
      redirect_to(current_user.admin? || current_user.manage? ? admin_users_path : admin_user_path(current_user))
    else
      semester_convert_date
      render :edit
    end
  end

  def destroy
    flag = @user.confirmed
    if @user.check_present?
      flash[:danger] = "mon hoc co gia tri con"
    elsif @user.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to(flag ? admin_users_path : admin_users_confirmed_path)
  end

  private
  def load_all_users
    @list_users = if current_user.admin?
                    User.load_users?
                        .user_less_than_role(current_user)
                        .user_confirmed true
                  else
                    User.load_users?
                        .load_user_of_school(current_user)
                        .user_less_than_role(current_user)
                        .user_confirmed true
                  end
  end

  def load_all_confirmed_users
    @list_users = if current_user.admin?
                    User.load_users?
                        .user_less_than_role(current_user)
                        .user_confirmed false
                  else
                    User.load_users?
                        .load_user_confirmed_of_school(current_user)
                        .user_less_than_role(current_user)
                        .user_confirmed false
                  end
  end

  def new_user
    @user = User.new
    semester_convert_date
  end

  def create_params
    params[:user][:birth] = convert_date params[:user][:birth]
    params.require(:user).permit :email, :phone, :name, :identity_card, :gender,
      :address, :birth, :role, :avatar, :working
  end

  def update_params
    params[:user][:birth] = convert_date params[:user][:birth]
    params.require(:user).permit :name, :identity_card, :gender, :address,
      :birth, :role, :avatar, :working
  end

  def get_user
    load_user
    if @user
      semester_convert_date
      return
    end
    flash[:danger] = "user not found"
    redirect_to admin_users_path
  end

  def get_user_confirm
    load_user
    if @user
      semester_convert_date
      return
    end
    flash[:danger] = "user not found"
    redirect_to admin_users_confirmed_path
  end

  def load_user
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
end
