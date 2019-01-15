class PointTypesController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_point_types, only: :index
  before_action :new_point_type, only: :new
  before_action :get_point_type, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    if @point_type.save
      flash[:success] = "create success"
      redirect_to point_types_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @point_type.update_attributes point_type_params
      flash[:success] = t "update_success"
      redirect_to point_types_path
    else
      render :edit
    end
  end

  def destroy
    if @point_type.check_present?
      flash[:danger] = "loai diem co gia tri con"
    elsif @point_type.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to point_types_path
  end

  private
  def load_all_point_types
    @point_types = PointType.load_all_point_types?
  end

  def new_point_type
    @point_type = PointType.new
  end

  def point_type_params
    params.require(:point_type).permit :name, :value
  end

  def get_point_type
    @point_type = PointType.find_by(id: params[:id])
    return if @point_type
    flash[:danger] = "point_type not found"
    redirect_to point_types_path
  end
end
