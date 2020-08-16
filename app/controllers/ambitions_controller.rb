class AmbitionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def new
    @ambition = current_user.ambitions.build
  end

  def create
    @ambition = current_user.ambitions.build(ambition_params)
    if @ambition.save
      flash[:success] = 'Objective作成に成功しました　一つ目のKRを作成しましょう'
      redirect_to root_url
    else
      flash[:danger] = 'Objective作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @ambition.update(ambition_params)
      flash[:success] = 'Objectiveは正常に更新されました'
      redirect_to @ambition
    else
      flash[:danger] = 'Objectiveは更新されませんでした'
      render :edit
    end
  end

  def destroy
    
    @ambition.destroy
    flash[:success] = 'Objectiveを削除しました'
    redirect_to user_path(current_user)
  end
  
  private
  
  def ambition_params
    params.require(:ambition).permit(:content, :start_date, :end_date)
  end
  
  def correct_user
    @ambition = Ambition.find(params[:id])
    unless current_user.id == @ambition.user_id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
end
