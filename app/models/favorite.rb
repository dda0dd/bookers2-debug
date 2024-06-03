class Favorite < ApplicationRecord
# favoriteモデルのuser_idカラムとUserモデルのidとの関連付け
  belongs_to :user
# favoriteモデルのbook_idカラムとBookモデルのidとの関連付け
  belongs_to :book

# 何度もいいねを押せないバリデーション設定（uniqueness指定で重複のテェック）
  # scope指定でuser_id,book_idペアに対して同じ値ペアがテーブルに保存されていないか判定
validates :user_id, uniqueness: {scope: :book_id}

end
