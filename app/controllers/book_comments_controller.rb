class BookCommentsController < ApplicationController

# コメント作成し、データベースに保存記述
  def create
    book = Book.find(params[:book_id])
# 下記はcomment =BookComment.new(book_comment_params)
# comment.user_id = current_user.idの省略記述
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
# コメント後は行う前（books/show）に遷移記述
    redirect_to book_path(book)
  end

# コメント削除機能
  def destroy
    BookComment.find(params[:id]).destroy
# コメント削除後は行う前（books/show）に遷移記述
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
