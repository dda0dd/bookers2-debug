class RelationshipsController < ApplicationController
# フォロー・フォロワー機能追加記述コントローラ

# createアクション追記（用途:フォロー作成）
  def create
# フォロー作成記述
  current_user.follow(params[:user_id])
  redirect_to request.referer
# 保存記述
  # followes.save
# フォローするボタンクリック後元画面に遷移記述
  # redirect_back fallback_location: root_path
  end

# destroyアクション追記（用途:フォロー削除）
  def destroy
# フォロー削除記述
  current_user.unfollow(params[:user_id])
  redirect_to request.referer
# フォロー外すボタンクリック後元画面に遷移記述
  # redirect_back fallback_location: root_path
  end
  
# フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
# フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
