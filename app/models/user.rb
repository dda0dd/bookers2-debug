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
  has_many :following, through: :relationships , source: :followed

# belongs_to :books
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
# 自己紹介文のバリデーションを追記
  validates :introduction, length: {maximum: 50}

# 今回は引数をつけない
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
