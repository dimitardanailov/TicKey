TicKey::Application.routes.draw do

  scope "/users" do
    post "/authenticate" => "users#authenticate",
      as: :user_authenticate

    post "/register_user" => "users#register_user",
      as: :user_register
  end
  
  scope "/vehicle_devices" do
    get "line_name_by_uuid/:uuid" => "vehicle_devices#get_line_name_by_uuid"
    get "get_vehicle_users/:uuid" => "vehicle_devices#get_vehicle_users"
  end

  scope "/card_purches" do
    get "user_active_cards/:user_id/:uuid" => "card_purches#get_active_tickets_by_uuid_and_user",
      :constraints => { :user_id => /\d+/ }
    
    post "make_order" => "card_purches#make_card_purches"
  end

  resources :card_purches

  resources :line_devices

  resources :lines

  resources :vehicle_devices

  resources :transport_card_types

  resources :users

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
end
