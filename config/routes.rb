TicKey::Application.routes.draw do

 resources :transport_card_types

  scope "(/:locale)", locale: /en|bg/ do

    #rails_admin routes
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

    namespace :api do
      scope "/users" do
       post "/authenticate" => "users#authenticate",
         as: :user_authenticate

        post "/register_user" => "users#register_user",
          as: :user_register
      end # end scope users

      scope "/card_purches" do
        get "user_active_cards/:user_id/:uuid" => "card_purchases#get_active_tickets_by_uuid_and_user",
          :constraints => { :user_id => /\d+/ }

        post "make_order" => "card_purchases#make_card_purchase"
      end # end scope card_purchases

      scope "/vehicle_devices" do
        get "line_name_by_uuid/:uuid" => "vehicle_devices#get_line_name_by_uuid"
        get "get_vehicle_users/:uuid" => "vehicle_devices#get_vehicle_users"
      end # end scope vehicle_devices
    end # end of namespace api

  end # end scope locales
end
