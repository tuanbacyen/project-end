class SchoolsController < ApplicationController
  load_and_authorize_resource except: :create

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_schools, only: :index
  before_action :new_school, only: :new
  before_action :get_school, only: [:destroy, :update, :edit]
  def index; end

  def new; end

  def create
    @school = School.new load_school
    if @school.save
      flash[:success] = "create success"
      redirect_to schools_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @school.update_attributes load_school
      flash[:success] = t "update_success"
      redirect_to schools_path
    else
      flash[:danger] = t "update failed"
      render :edit
    end
  end

  def destroy
    if @school.check_present?
      flash[:danger] = "truong hoc co truong con"
    elsif @school.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to schools_path
  end

  private
  def load_all_schools
    @schools = School.load_all_schools?
  end

  def new_school
    @school = School.new
  end

  def load_school
    params.require(:school).permit :name, :address, :phone
  end

  def get_school
    @school = School.find_by(id: params[:id])
    return if @school
    flash[:danger] = "school not found"
    redirect_to schools_path
  end
end
