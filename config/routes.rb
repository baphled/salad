ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  map.resources :projects, :collection => {:tags => :get, :valid_directory => :get}
  map.resources :features, :collection => {:tags => :get,:sort => :post}
  map.resources :stories, :collection => {:tags => :get,:sort => :post,:add_step => :get}
  map.resources :steps, :collection => {:tags => :get, :sort => :post, :validate => :get}

  
  map.project_tag 'projects/tag/:tag', :controller => 'projects', :action => 'tag'
  map.feature_tag 'features/tag/:tag', :controller => 'features', :action => 'tag'
  map.story_tag 'stories/tag/:tag', :controller => 'stories', :action => 'tag'

  map.feature_export 'features/:id/export', :controller => 'features', :action => 'export'
  
  map.add_stories_step 'stories/:id/add_step', :controller => 'stories', :action => 'add_step'
  map.project_features 'projects/:id/features', :controller => 'projects', :action => 'features'
  map.project_import 'projects/:id/import', :controller => 'projects', :action => 'import'
  map.feature_stories 'features/:id/stories', :controller => 'features', :action => 'stories'
  map.story_steps 'stories/:id/steps', :controller => 'stories', :action => 'steps'
  
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
