class RelationshipsController < ApplicationController
# フォロー・フォロワー機能追加記述コントローラ

  def create
# フォロー作成記述
# フォローするボタンクリック後元画面に遷移記述
redirect_back fallback_location: root_path
  end

  def destroy
# フォロー削除記述
# フォロー外すボタンクリック後元画面に遷移記述
redirect_back fallback_location: root_path
  end
end
