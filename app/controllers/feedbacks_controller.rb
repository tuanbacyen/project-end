class FeedbacksController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_all_feedbacks, only: :index
  before_action :new_feedback, only: :new
  before_action :get_feedback, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    @feedback.from_id = current_user.id
    if @feedback.save
      flash[:success] = "create success"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @feedback.update status: true
      flash[:success] = t "update_success"
    else
      flash[:success] = t "Loiiiiii"
    end
    redirect_to feedbacks_path
  end

  def destroy
    if @feedback.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to feedbacks_path
  end

  private
  def load_all_feedbacks
    @feedbacks = Feedback.load_all_feedbacks?
  end

  def new_feedback
    @feedback = Feedback.new
  end

  def feedback_params
    params.require(:feedback).permit :content
  end

  def get_feedback
    @feedback = Feedback.find_by(id: params[:id])
    return if @feedback
    flash[:danger] = "feedback not found"
    redirect_to feedbacks_path
  end
end
