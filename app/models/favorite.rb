class Favorite < ApplicationRecord
# favoriteモデルのuser_idカラムとUserモデルのidとの関連付け
  belongs_to :user

end
