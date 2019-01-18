class PointsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :get_student_subject, only: :new
  before_action :load_points_student, only: :show
  before_action :new_point, only: :new
  before_action :get_point, only: [:destroy, :update, :edit]

  def show; end

  def new; end

  def create
    if @point.save
      flash[:success] = "create success"
      redirect_to points_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @point.update_attributes point_params
      flash[:success] = t "update_success"
      redirect_to student_subject_path(params[:point][:student_subject_id])
    else
      render :edit
    end
  end

  def destroy
    if @point.check_present?
      flash[:danger] = "loai diem co gia tri con"
    elsif @point.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to points_path
  end

  private
  def get_student_subject
    @student_subject = StudentSubject.find_by(id: params[:student_subject_id])
    return if @student_subject
    flash[:danger] = "student not found"
    redirect_to student_path
  end

  def load_all_points
    @points = nil
  end

  def new_point
    @point = Point.new
  end

  def point_params
    params.require(:point).permit :point, :point_type_id, :student_subject_id
  end

  def get_point
    @point = Point.find_by(id: params[:id])
    return if @point
    flash[:danger] = "point not found"
    redirect_to root_path
  end
end
