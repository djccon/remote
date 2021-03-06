Remote::Application.routes.draw do
  resources :live_xyzs


  resources :result_items


  resources :users


  resources :club_path_items


  resources :club_paths


  resources :ball_flight_items


  resources :ball_flights


  resources :weather_items


  resources :weathers


  resources :command_items


  resources :ball_landing_items


  resources :debug_outputs


  resources :ball_landings


  resources :launch_items


  resources :launches


  resources :shots


  resources :command_blocks


  resources :responses


  resources :commands


  get "test/send_command"
  get "test/get_commands"

  get "api/send_command"
  get "api/get_commands"
  get "api/get_all_commands"
  get "api/send_response"
  get "api/get_responses"
  get "api/get_all_responses"
  get "api/push_command_block"
  get "api/get_latest_weather"
  get "api/get_command_item"
  get "api/get_leaderboard"
  get "api/get_score_history"
  get "api/send_email"
  get "api/get_live_xyz"
  post "api/set_live_xyz"

  put "api/send_swing_command"
  
  post "api/send_shot_launch_conditions"
  post "api/send_shot_ball_landing"
  post "api/send_shot_weather"
  post "api/send_shot_ball_flight"
  post "api/send_shot_club_path"
  post "api/send_weather"
  post "api/create_shot"
  post "api/output_debug_string"
  post "api/mimic_params"



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
