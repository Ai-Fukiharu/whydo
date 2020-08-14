class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit ,:update]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録に成功しました ログインが可能です'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @current_user.update(user_params)
      flash[:success] = 'ユーザー情報を変更しました'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザー情報が変更できませんでした'
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    
end

