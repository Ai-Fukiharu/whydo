class DailyResultsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @key_result = KeyResult.find(params[:id])
    @ambition = @key_result.ambition
    
    unless current_user.id == @ambition.user_id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
    
    @daily_result = @key_result.daily_results.build
  end

  def create
    @key_result = KeyResult.find(params[:key_result_id])
    @ambition = @key_result.ambition
    @daily_result = @key_result.daily_results.build(daily_result_params)
    
    if @key_result.numerical_goal < @daily_result.result
      flash[:danger] = '評価値は目標数値より大きくしないでください'
      render :new
    elsif @ambition.start_date > @daily_result.result_date || @ambition.end_date <@daily_result.result_date
      flash[:danger] = '評価はObjectiveの期間内に行ってください'
      render :new
    elsif @daily_result.save
      flash[:success] = '評価の保存に成功しました'
      redirect_to @ambition
    else
      flash[:danger] = '評価の保存に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    @result = params[:daily_result][:result].to_i
    
    if @key_result.numerical_goal < @result
      flash[:danger] = '評価値は目標数値より大きくしないでください'
      render :edit
    elsif @daily_result.update(daily_result_params)
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