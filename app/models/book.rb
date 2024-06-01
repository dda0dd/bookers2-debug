class Book < ApplicationRecord
# 画像のアソシエーション追記
  has_one_attached :image

# has_many :userを変更（1対Nの関係）
  belongs_to :user
  # has_many :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
