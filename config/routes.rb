TicKey::Application.routes.draw do

#  get "users/authenticate"
#  get "users/register_user"
 #get "transport_card_types/index"
 resources :transport_card_types

  scope "(/:locale)", locale: /en|bg/ do

    #rails_admin routes
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

    scope "/users" do
      post "/authenticate" => "users#authenticate",
        as: :user_authenticate

      post "/register_user" => "users#register_user",
        as: :user_register
    end # end scope users



    scope "/vehicle_devices" do
      get "line_name_by_uuid/:uuid" => "vehicle_devices#get_line_name_by_uuid"
      get "get_vehicle_users/:uuid" => "vehicle_devices#get_vehicle_users"
    end # end scope vehicle_devices

    scope "/card_purches" do
      get "user_active_cards/:user_id/:uuid" => "card_purches#get_active_tickets_by_uuid_and_user",
        :constraints => { :user_id => /\d+/ }

      post "make_order" => "card_purches#make_card_purches"
    end # end scope card purchases



    namespace :api do
      scope "/users" do
       post "/authenticate" => "users#authenticate",
         as: :user_authenticate

        get "/authenticate/email/:email/password/:password" => "users#authenticate"

        post "/register_user" => "users#register_user",
          as: :user_register
      end # end scope users
    end # end of namespace api

#    scope "/cms" do
#      resources :card_purches
#
#      resources :line_devices
#
#      resources :lines
#
#      resources :vehicle_devices
#
#      resources :transport_card_types
#
#      resources :users
#    end # end scope cms

  end # end scope locales
end
