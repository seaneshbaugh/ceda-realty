ActionController::Routing::Routes.draw do |map|
  map.resources :agents, :only => [:index, :show], :member => {:contact => :get, :send_message => :post}

  #map.resources :agent_resources

  map.resources :blogs, :only => [:index, :show]

  #map.resources :boards

  map.resources :listings, :only => [:index, :show], :collection => {:search_mls => :post, :advanced_search => :get}

  #map.resources :logger_events

  map.resources :pages, :only => [:index, :show]

  map.resources :people, :except => [:index, :show, :new, :create, :edit, :update, :destroy], :collection => {:help => :get, :recover => :post}, :member => {:send_message => :get}

  #map.resources :pictures

  map.resources :posts, :only => [:index, :show]

  map.resources :sessions, :only => [:new, :create, :destroy], :member => {:recovery => :get}

  map.namespace :admin do |admin|
    admin.resources :agents, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.resources :agent_resources, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}, :member => {:get_file => :get}
    admin.resources :blogs, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.resources :boards, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.resources :listings, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post, :import => :post}
	admin.resources :logger_events, :except => [:new, :create, :edit, :update], :collection => {:destroy_multiple => :post}
    admin.resources :pages, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.resources :people, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.resources :pictures, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.resources :posts, :collection => {:edit_multiple => :post, :update_multiple => :put, :destroy_multiple => :post}
    admin.reboot "reboot", :controller => "admin", :action => "reboot"
    admin.root :controller => "admin", :action => "index"
  end

  map.namespace :agent do |agent|
	agent.resources :agents, :only => [:edit, :update]
	agent.resources :agent_resources, :only => [:index, :show], :member => {:get_file => :get}
	agent.resources :blogs
	agent.resources :boards, :only => [:index, :show]
	agent.resources :logger_events, :except => [:new, :create, :edit, :update]
	agent.resources :people, :only => [:edit, :update]
	agent.resources :pictures
	agent.resources :posts
	agent.root :controller => "agent", :action => "index"
  end

  map.sitemap "/sitemap.xml", :controller => "sitemap", :action => "index"

  map.root :controller => "pages"

  # The priority is based upon order of creation: first created -> highest priority.

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

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
