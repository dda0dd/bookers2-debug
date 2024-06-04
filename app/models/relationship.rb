class Relationship < ApplicationRecord
# フォロー機能記述
# リレーション記述 クラス名:モデル名指定
  # class_nameオプション=follower,followed名でUserモデルの関連付けを行う
  belongs_to :follower, class_name: "User"
# オブジェクト名(followed)でUserモデルとのリレーションを行う設定
  belongs_to :followed, class_name: "User"
end
