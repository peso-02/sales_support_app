Rails.application.routes.draw do
  resources :customers
  devise_for :users
  
  # ダッシュボードをルートに設定
  root 'dashboard#index'
  get 'dashboard/index'
  
# 得意先管理
  resources :customers
  
end
