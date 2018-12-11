class HomeController < ApplicationController
  before_action :user_confirmed, :authenticate_user!
  
  def index
  end
end
