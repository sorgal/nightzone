Nightzone::Application.routes.draw do

  controller :code_compares do
    post 'code_compares/', :to => 'code_compares#create'
    delete 'code_compares/:id', :to => 'code_compares#destroy'
  end

  controller :game_codes do
    post 'game_codes/', :to => 'game_codes#create'
    delete 'game_codes/:id', :to => 'game_codes#destroy'
  end

  resources :codes

  controller :game_hints do
    post 'game_hints/', :to => 'game_hints#create'
    delete 'game_hints/:id', :to => 'game_hints#destroy'
  end

  resources :user_games

  resources :hints

  controller :admin_games do
    post 'admin_games/', :to => 'admin_games#create'
    delete 'admin_games/:id', :to => 'admin_games#destroy'
  end

  resources :games

  devise_for :users
  get "home/index"
  get "home/game_code_compares"
  post "home/create_code_compare"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root :to => "home#index"

end
