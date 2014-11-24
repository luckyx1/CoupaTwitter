CoupaTwitter::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # RAILS_DEFAULT_LOGGER = x

  # root :to => 'users#create***********************************'
  # # Sample of regular route:
  # match 'products/:id' => 'catalog#view'

  map.resources :posts, :collection => { :generate_pdf => :get }, :member => {:activate => :post} do |posts|
      posts.resources :comments
  end
  # # Keep in mind you can assign values other than :controller and :action

  # # Sample of named route:
  # #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # # This route can be invoked with purchase_url(:id => product.id)

  # # Sample resource route (maps HTTP verbs to controller actions automatically):
  # #   resources :products
  # RAILS_ENV == 'development'

  # map.namespace :admin do |admin|
  #     admin.resources :users
  # end
  # # Sample resource route with options:
  # #   resources :products do
  # #     member do
  # #       get 'short'
  # #       post 'toggle'
  # #     end
  # #
  # #     collection do
  # #       get 'sold'
  # #     end
  # #   end
  # map.root :controller => "home", :action => :index


  # # Sample resource route with sub-resources:
  # #   resources :products do
  # #     resources :comments, :sales
  # #     resource :seller
  # #   end
  # map.connect "/main/:id", :controller => "main", :action => "home"


  # # Sample resource route with more complex sub-resources
  # #   resources :products do
  # #     resources :comments
  # #     resources :sales do
  # #       get 'recent', :on => :collection
  # #     end
  # #   end
  # map.connect "/:controller/:action/:id"


  # # Sample resource route within a namespace:
  # #   namespace :admin do
  # #     # Directs /admin/products/* to Admin::ProductsController
  # #     # (app/controllers/admin/products_controller.rb)
  # #     resources :products
  # #   end
  # map.admin_signup "/admin_signup", :controller => "admin_signup", :action => "new", :method => "post"


  # # You can have the root of your site routed with "root"
  # # just remember to delete public/index.html.
  # # root :to => "welcome#index"
  # map.with_options :controller => "manage" do |manage|
  #   manage.manage_index "manage_index", :action => "index"
  #   manage.manage_intro "manage_intro", :action => "intro"
  # end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end