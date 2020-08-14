class ToppagesController < ApplicationController
  def index
    if logged_in?
      @ambitions = current_user.ambitions.order(end_date: :desc).page(params[:page]).per(3)
    end
  end
end
