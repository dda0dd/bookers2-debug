class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
# 空のモデルを渡す（@bookにすると全てBook.newになるので記述を変える）
    @book_new = Book.new
  end

  def index
    @books = Book.all
# books/indexの@bookを定義（本の投稿なので.new）
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
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
    @book.destoy
    redirect_to books_path
  end

  private
# どれを確認するか
  def book_params
# 何が許可されているか（今許可されているのは:title, :bodyになる）
    params.require(:book).permit(:title, :body)
  end
end
