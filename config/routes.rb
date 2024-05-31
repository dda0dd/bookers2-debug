Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# 記載順を変更
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]

  resources :users, only: [:index,:show,:edit,:update]
# root :to =>をroot to:に変更
  root to: "homes#top"
  get "home/about"=>"homes#about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# rails db:migrate RAILS_ENV=test時にsyntax error発生でend追記
end
