class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
# いいね削除後は行う前にいた画面（books/index）に遷移記述
  # redirect_back使用時は直前ページに戻れなかった際のパス（root_path）が必要
    redirect_back fallback_location: root_path
# いいねを付けて保存後は本の詳細ページ(books/show)にリダイレクトされる設定
    # redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
# いいね削除後は行う前にいた画面（books/index）に遷移記述
  # redirect_back使用時は直前ページに戻れなかった際のパス（root_path）が必要
    redirect_back fallback_location: root_path
# いいねを削除後は本の詳細ページ(books/show)にリダイレクトされる設定
    # redirect_to book_path(book)
  end

end
