class UnitsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_units, only: :index
  before_action :new_unit, only: :new
  before_action :get_unit, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    if @unit.save
      flash[:success] = "create success"
      redirect_to units_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @unit.update_attributes update_params
      flash[:success] = t "update_success"
      redirect_to units_path
    else
      render :edit
    end
  end

  def destroy
    if @unit.check_present?
      flash[:danger] = "truong hoc co gia tri con"
    elsif @unit.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to units_path
  end

  def new_auto; end

  def create_auto
    unit = UnitService.new params
    unit.auto_create_unit
    flash[:success] = "done"
    redirect_to units_path
  end

  private
  def load_all_units
    @units = Unit.load_all_units?
  end

  def new_unit
    @unit = Unit.new
  end

  def unit_params
    params.require(:unit).permit :numunit, :time_start, :time_end
  end

  def update_params
    params.require(:unit).permit :time_start, :time_end
  end

  def get_unit
    @unit = Unit.find_by(id: params[:id])
    if @unit
    else
      flash[:danger] = "unit not found"
      redirect_to units_path
    end
  end
end
