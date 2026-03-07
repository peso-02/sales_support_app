Rails.application.routes.draw do
  resources :product_prices
  resources :products

  devise_for :users
  
  # ダッシュボードをルートに設定
  root 'dashboard#index'
  get 'dashboard/index'
  
# 得意先管理
  resources :customers do
    collection do
      post :import
    end
    resources :product_prices, only: [:index, :new, :create, :edit, :update, :destroy]
  end
# 仕入先管理
  resources :suppliers do
    collection do
      post :import
    end
    resources :supplier_contacts, only: [:new, :create, :edit, :update, :destroy]
  end
# 商品管理
  resources :products

end
