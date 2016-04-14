Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  post 'brands/new' => 'brands#create'
  get 'brands' => 'brands#index'
  get 'brands/count' => 'brands#count'
  get 'brands/range/:id' => 'brands#range'
  get 'brands/range/:id/:count' => 'brands#range_count'
  get 'brands/:id' => 'brands#show'
  put 'brands/:id' => 'brands#edit'
  post 'brands/:id' => 'brands#destroy'

  post 'categories/new' => 'categories#create'
  get 'categories' => 'categories#index'
  get 'categories/count' => 'categories#count'
  get 'categories/range/:id' => 'categories#range'
  get 'categories/range/:id/:count' => 'categories#range_count'
  get 'categories/:id' => 'categories#show'
  put 'categories/:id' => 'categories#edit'
  post 'categories/:id' => 'categories#destroy'

  post 'products/new' => 'products#create'
  get 'products' => 'products#index'
  get 'products/count' => 'products#count'
  get 'products/range/:id' => 'products#range'
  get 'products/range/:id/:count' => 'products#range_count'
  get 'products/:id' => 'products#show'
  put 'products/:id' => 'products#edit'
  post 'products/:id' => 'products#destroy'

  get 'search/:type/:slug' => 'searches#find_by_type'
  get 'search/:type/:property/:slug' => 'searches#find_by_type_and_property'

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
