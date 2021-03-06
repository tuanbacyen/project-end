class ClassroomsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_classrooms, only: :index
  before_action :new_classroom, only: :new
  before_action :get_classroom, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    if @classroom.save
      flash[:success] = "create success"
      redirect_to classrooms_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @classroom.update_attributes classroom_params
      flash[:success] = t "update success"
      redirect_to classrooms_path
    else
      render :edit
    end
  end

  def destroy
    if @classroom.check_present?
      flash[:danger] = "mon hoc co gia tri con"
    elsif @classroom.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to classrooms_path
  end

  private
  def load_all_classrooms
    @classrooms = Classroom.load_all_classrooms current_user
  end

  def new_classroom
    @classroom = Classroom.new
  end

  def classroom_params
    params.require(:classroom).permit :school_id, :semester_id, :user_id, :name, :sizes, :number
  end

  def get_classroom
    @classroom = Classroom.find_by(id: params[:id])
    return if @classroom
    flash[:danger] = "classroom not found"
    redirect_to classrooms_path
  end
end
