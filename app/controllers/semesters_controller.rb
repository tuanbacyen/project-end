class SemestersController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_semesters, only: :index
  before_action :new_semester, only: :new
  before_action :get_semester, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    if @semester.save
      flash[:success] = "create success"
      redirect_to semesters_path
    else
      semester_convert_date
      render :new
    end
  end

  def edit; end

  def update
    if @semester.update_attributes semester_params
      flash[:success] = t "update success"
      redirect_to semesters_path
    else
      semester_convert_date
      render :edit
    end
  end

  def destroy
    if @semester.check_present?
      flash[:danger] = "truong hoc co gia tri con"
    elsif @semester.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to semesters_path
  end

  private
  def load_all_semesters
    @semesters = Semester.load_all_semesters?
  end

  def new_semester
    @semester = Semester.new
  end

  def semester_params
    params[:semester][:start_date] = convert_date params[:semester][:start_date]
    params[:semester][:end_date] = convert_date params[:semester][:end_date]
    params.require(:semester).permit :period, :start_date, :end_date, :school_year
  end

  def get_semester
    @semester = Semester.find_by(id: params[:id])
    if @semester
      semester_convert_date
    else
      flash[:danger] = "semester not found"
      redirect_to semesters_path
    end
  end

  def semester_convert_date
    @semester.start_date = convert_date_to_local @semester.start_date
    @semester.end_date = convert_date_to_local @semester.end_date
  end
end
