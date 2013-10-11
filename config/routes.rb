SoccerleagueApp::Application.routes.draw do
  scope "/:locale", :shallow_path => "(:locale)" do
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
    devise_scope :user do
      get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    end

    resources :users
    resources :rosters
    resources :careers
    resources :technicalstaffs
    resources :playerstats
    resources :teams
    resources :people
    resources :playinglocations
    resources :venues
    resources :team_league_history

    resources :games do
      resources :teamstats do
        resources :playerstats, :shallow => true
      end
    end

    resources :leagues do
      resources :teamstats, :shallow => true do
        resources :rosters, :shallow => true
        resources :technicalstaffs, :shallow => true
        resources :playinglocations, :shallow => true
      end
      resources :games, :shallow => true
      resources :leaguezones, :shallow => true
    end

    resources :organizations do
      resources :leagues, :shallow => true
    end

    match '/home',    :to => 'pages#home'
    match '/contact', :to => 'pages#contact'
    match '/about',   :to => 'pages#about'
    match '/help',    :to => 'pages#help'
  end

  root :to => 'pages#home'

  match '/:locale' => 'pages#home'

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
