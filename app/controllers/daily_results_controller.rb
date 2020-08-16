class DailyResultsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @key_result = KeyResult.find(params[:id])
    @ambition = @key_result.ambition
    @daily_result = @key_result.daily_results.build
  end

  def create
    @key_result = KeyResult.find(params[:key_result_id])
    @ambition = @key_result.ambition
    @daily_result = @key_result.daily_results.build(daily_result_params)
    if @daily_result.save
      flash[:success] = '本日の評価に成功しました'
      redirect_to @ambition
    else
      flash[:danger] = '本日の評価に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @daily_result.update(daily_result_params)
      flash[:success] = '評価の変更に成功しました'
      redirect_to @ambition
    else
       flash[:danger] = '評価の変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @daily_result.destroy
    flash[:success] = '評価履歴を削除しました'
    redirect_to @ambition
  end

  private 

  def daily_result_params
    params.require(:daily_result).permit(:result, :result_date)
  end

  def correct_user
    @daily_result = DailyResult.find(params[:id])
    @key_result = @daily_result.key_result
    @ambition = @key_result.ambition
    unless current_user.id == @ambition.user_id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
end