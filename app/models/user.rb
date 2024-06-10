class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# belongs_to :booksを変更（1対Nの関係）
  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy
# Userデータ削除時にそのUserが投稿したコメントデータも一緒に削除（1:Nの関係）
  has_many :book_comments, dependent: :destroy

# あるユーザをフォローしている人（フォロワー）の一覧取得アソシエーション記述
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
# あるユーザがフォローしている人（フォロイー）一覧取得アソシエーション記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
# sourceオプション=違った関連付け名でも関連元の名前を指定できる
  has_many :followings, through: :relationships , source: :followed
# メソッド記述(フォローした時の処理)
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
# メソッド記述（フォロー外す時の処理）
  def unfollow(user_id)
# find_by(探す)
    follower = relationships.find_by(followed_id: user_id)
# フォロー外すボタンクリック後（削除処理）記述
    follower.destroy
  end
# メソッド記述（フォローしているか判定）
  def following?(user)
    followings.include?(user)
  end

# belongs_to :books
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
# 自己紹介文のバリデーションを追記
  validates :introduction, length: {maximum: 50}

# 検索方法の分岐定義(検索方法毎に適した検索が行われる)
  def self.looks(search, word)
# perfect_match=完全一致（検索方法）送られてきたsearchで条件分岐
    if search == "perfect_match"
# name=検索対象usersテーブル内カラム名
      @user = User.where("name LIKE ?", "#{word}")
# forward_match=前方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "forward_match"
# 完全一致以外の検索方法は #{word}前後か両方に % 追記で定義
      @user = User.where("name LIKE ?", "#{word}%")
# backward_match=後方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "backward_match"
# whereメソッドでデータベースから該当データ取得、変数(@user)に代入
      @user = User.where("name LIKE ?", "%#{word}")
# partial_match=部分一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "partial_match"
      @user = User.where("name LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end

# 今回は引数をつけない
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
