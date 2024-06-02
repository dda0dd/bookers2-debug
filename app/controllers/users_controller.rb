class UsersController < ApplicationController
# 他ユーザのプロフィールを編集できないよう(, :edit)追記
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
# .newは新規投稿Title下のboxを表示する時などに使用記述
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
# end追記
  end

  def edit
  # URLの表示がusers.1になっているのでusers/1に変更記述
    @user = User.find(params[:id])
  # プロフィール編集が失敗した後自分の詳細ページ表示記述
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    if @user.update(user_params)
  # usersのsを外す（users/showへのリンクなので）
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
  # users/_indexのeachメソッドbooksを定義
      @books = Book.all
  # エラー後はusers/editに遷移する記述
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
