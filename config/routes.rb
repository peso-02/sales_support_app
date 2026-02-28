Rails.application.routes.draw do

  devise_for :users
  
  # ダッシュボードをルートに設定
  root 'dashboard#index'
  get 'dashboard/index'
  
# 得意先管理
  resources :customers
# 仕入先管理
  resources :suppliers do
    resources :supplier_contacts, only: [:new, :create, :edit, :update, :destroy]
  end
  
end
