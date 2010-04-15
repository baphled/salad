ActionController::Routing::Routes.draw do |map|
  map.resources :projects,
    :collection => {:tags => :get,
                    :valid_directory => :get,
                    :validate => :get},
    :member => {:features => :get,
                :import_feature => :get,
                :import => :get}
              
  map.resources :features,
    :collection => {:tags => :get,
                    :sort => :post,
                    :import => :get,
                    :validate => :get},
    :member => {:stories => :get,
                :merge => :get,
                :changes => :get,
                :file_merge => :get,
                :sync => :get,
                :export => :get}

  map.resources :stories,
    :collection => {:tags => :get,
                    :sort => :post,
                    :validate => :get},
    :member => {:steps => :get,
                :add_step => :post}

  map.resources :steps,
    :collection => {:tags => :get,
                    :sort => :post,
                    :validate_prefix => :get}

  
  map.project_tag 'projects/tag/:tag', :controller => 'projects', :action => 'tag'
  map.feature_tag 'features/tag/:tag', :controller => 'features', :action => 'tag'
  map.story_tag 'stories/tag/:tag', :controller => 'stories', :action => 'tag'

  map.root :controller => "welcome"
  
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
