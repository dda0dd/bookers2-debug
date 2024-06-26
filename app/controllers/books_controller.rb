class BooksController < ApplicationController

  def show
# Bookmodelから:id(に入る値１など)を探す
  # params=Parameters: {"id" => "1"}(実行時のターミナルに記載されている)を指定している
    @book = Book.find(params[:id])
# コメント投稿するインスタンス変数を定義
    @book_comment = BookComment.new

# 空のモデルを渡す（@bookにすると全てBook.newになるので記述を変える）
    @book_new = Book.new
# users/_infoのimage_tag userが空（books/showの@userを定義）
  # 本を投稿したユーザに変更
    @user = @book.user
  end

  def index
    @books = Book.all
# books/indexの@bookを定義（本の投稿なので.new）
    @book = Book.new
  end

  def create
# (book_params)＝params.require(:book).permit(:title, :body)で許可したものを入れる
  # Book.new＝空のbookboxに(book_params)＝許可した値を入れる（例:title,:body）
    @book = Book.new(book_params)
# 1:N(アソシエーション)でN側をcreateする時のみ使用記述
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
# 本の投稿ユーザと今ログインしたユーザを比較処理（ログイン中にURLに入力で他人が投稿本編集ページに遷移できない）
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

# deleteをdestroyに変更
  def destroy
    @book = Book.find(params[:id])
# rが抜けていてエラー発生
    @book.destroy
    redirect_to books_path
  end

  private
# どれを確認するか（bookmodelで）
  def book_params
# 何が許可されているか（今許可されているのは:title, :bodyになる）
  # require=求める,permit=許可（投稿機能のcontrollerには必ず記述）
    params.require(:book).permit(:title, :body)
  end
end
