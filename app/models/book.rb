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

# 検索方法の分岐定義(検索方法毎に適した検索が行われる)
  def self.looks(search, word)
# perfect_match=完全一致（検索方法）送られてきたsearchで条件分岐
    if search == "perfect_match"
# title=検索対象booksテーブル内カラム名
      @book = Book.where("title LIKE ?", "#{word}")
# forward_match=前方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "forward_match"
# 完全一致以外の検索方法は #{word}前後か両方に % 追記で定義
      @book = Book.where("title LIKE ?", "#{word}%")
# backward_match=後方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "backward_match"
# whereメソッドでデータベースから該当データ取得、変数(@user)に代入
      @book = Book.where("title LIKE ?", "%#{word}")
# partial_match=部分一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "partial_match"
      @book = Book.where("title LIKE ?", "%#{word}%")
    else
      @book = Book.all
    end
  end
# NoMethodError in SearchesController#search
  # undefined method 'looks' for Book:Classのエラー発生（原因はClass~end内にlooksの記述が入っていなかった）
end