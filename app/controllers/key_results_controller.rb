class KeyResultsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @ambition = Ambition.find(params[:id])
    @key_result = @ambition.key_results.build
  end

  def create
    @ambition = Ambition.find(params[:ambition_id])
    @key_result = @ambition.key_results.build(key_result_params)
    if @key_result.save
      flash[:success] = 'Key Resultの作成に成功しました'
      redirect_to @ambition
    else
      flash[:danger] = 'Key Resultの作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @key_result.update(key_result_params)
      flash[:success] = 'Key Resultの保存に成功しました'
      redirect_to @ambition
    else
       flash[:danger] = 'Key Resultの保存に失敗しました'
      render :edit
    end
  end

  def destroy
    @key_result.destroy
    flash[:success] = 'Key Resultを削除しました'
    redirect_to @ambition
  end
  
  private
  
  def key_result_params
    params.require(:key_result).permit(:content, :numerical_goal)
  end
  
  def correct_user
    @key_result = KeyResult.find(params[:id])
    @ambition = @key_result.ambition
    unless current_user.id == @ambition.user_id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
end
