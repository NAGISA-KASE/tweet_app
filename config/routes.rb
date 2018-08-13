Rails.application.routes.draw do
  # ---------------------- likes ----------------------------------
  post "likes/:post_id/create" => "likes#create" # いいね！機能
  post "likes/:post_id/destroy" => "likes#destroy" # いいね！取り消し機能

  post "likes/:post_id/create_index" => "likes#create_index" # 投稿一覧ページ用いいね！機能
  post "likes/:post_id/destroy_index" => "likes#destroy_index" # 投稿一覧ページ用いいね！取り消し機能
  # ---------------------- users ----------------------------------
  get "login" => "users#login_form" # ログインページ
  post "login" => "users#login" #ログイン機能
  post "logout" => "users#logout" #ログアウト機能

  get "users/index" # ユーザー一覧ページ
  get "users/:id" => "users#show" # ユーザー詳細ページ
  get "signup" => "users#new" # 新規登録ページ
  post "users/create" => "users#create", as:"users" # 新規登録保存機能

  get "users/:id/edit" => "users#edit" # ユーザー編集ページ
  #post "users/:id/update" , as:"users"
  put "users/:id/update" => "users#update", as:"user" # ユーザー編集内容保存機能
  get "users/:id/likes" => "users#likes" #ユーザーがいいね！した投稿一覧ページ
  # ---------------------- posts ----------------------------------
  get "posts/index" => "posts#index"  # 投稿一覧

  get "posts/new" => "posts#new"  # 新規投稿ページ
  post "posts/create" => "posts#create" # 新規投稿保存機能

  get "posts/:id" => "posts#show"  # 投稿詳細ページ

  get "posts/:id/edit" => "posts#edit" # 投稿編集ページ
  post "posts/:id/update" => "posts#update" # 編集内容保存機能

  post "posts/:id/destroy" => "posts#destroy" # 投稿削除機能

  # ---------------------- home ----------------------------------
  get "/" => "home#top"
  get "/about" => "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
