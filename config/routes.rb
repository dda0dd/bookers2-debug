Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# 記載順を変更
  devise_for :users

# コメントは投稿本に対してコメントされる（book_commentsはbooksと結びつき親子関係に）do~end
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
# いいね機能（1ユーザは一つの投稿に一回しかいいねできない仕様）
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

# resource(単数形)=/:idがURLに含まれない
  resource :favorite, only: [:create, :destroy]
# フォロー・フォロワー機能記述（ネストさせる）
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

# 検索ボタンクリックでSearchesコントローラのsearchアクションが実行される定義
  get "search" => "searches#search"

# root :to =>をroot to:に変更
  root to: 'homes#top'
# , as: 'about'追記
  get 'home/about' =>'homes#about', as: 'about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# rails db:migrate RAILS_ENV=test時にsyntax error発生でend追記
end
