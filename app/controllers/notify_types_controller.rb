class NotifyTypesController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_notify_types, only: :index
  before_action :new_notify_type, only: :new
  before_action :get_notify_type, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    if @notify_type.save
      flash[:success] = "create success"
      redirect_to notify_types_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @notify_type.update_attributes notify_type_params
      flash[:success] = t "update_success"
      redirect_to notify_types_path
    else
      render :edit
    end
  end

  def destroy
    if @notify_type.check_present?
      flash[:danger] = "mon hoc co gia tri con"
    elsif @notify_type.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to notify_types_path
  end

  private
  def load_all_notify_types
    @notify_types = NotifyType.load_all_notify_types?
  end

  def new_notify_type
    @notify_type = NotifyType.new
  end

  def notify_type_params
    params.require(:notify_type).permit :name
  end

  def get_notify_type
    @notify_type = NotifyType.find_by(id: params[:id])
    return if @notify_type
    flash[:danger] = "notify_type not found"
    redirect_to notify_types_path
  end
end
