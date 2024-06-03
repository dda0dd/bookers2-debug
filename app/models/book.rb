class Book < ApplicationRecord
# 画像のアソシエーション追記
  has_one_attached :image

# has_many :userを変更（1対Nの関係）
  belongs_to :user
  # has_many :user
# BookCommentモデルとの関連付け（BookCommentモデルを複数持つ=has_manyで表す）
  has_many :book_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
# favorited_by?メソッドは引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するか調べる
  # （user）=引数
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
# 存在している（true）存在していない（false）返す
  end

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
