class RelationshipsController < ApplicationController
# フォロー・フォロワー機能追加記述コントローラ

  def create
# フォロー作成記述
  book = Book.find(params[:book_id])
  favorite = current_user.favorites.new(book_id: book.id)
# 保存記述
  followes.save
# フォローするボタンクリック後元画面に遷移記述
  redirect_back fallback_location: root_path
  end

  def destroy
# フォロー削除記述
  book = Book.find(params[:book_id])
  favorite = current_user.favorites.find_by(book_id: book.id)
# フォロー外すボタンクリック後元画面に遷移記述
  redirect_back fallback_location: root_path
  end
end
