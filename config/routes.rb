Rails.application.routes.draw do

  resources :students, :except => [:show]
  resources :welcome, :except => [:index, :create]

  root to: 'welcome#index'
  post '/' => 'welcome#create'

  #login
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  #profile page
  get 'students/:id' => 'students#show', as: :student_profile

  #log in with twitter
  get '/login/twitter', to: redirect('/auth/twitter'), as: :twitter_login
  get '/auth/twitter/callback' => "students#twitter_connect"
  get '/logout/twitter' => 'sessions#destroy_twitter', as: :twitter_log_out
 
  #log in with github
  get '/login/github', to: redirect('/auth/github')
  get '/auth/github/callback' => "students#github_connect"
  get '/logout/github' => 'students#destroy_github'
  

  #follow cohorts
  get '/cohorts/follow/:provider' => 'cohorts#follow'
  put '/cohorts/:id/follow/:provider' => 'cohorts#follow_cohort', as: :follow_cohort 

  #cohorts crud
  resources :cohorts


end

# Prefix Verb   URI Pattern                  Controller#Action
#     students GET    /students(.:format)          students#index
#              POST   /students(.:format)          students#create
#  new_student GET    /students/new(.:format)      students#new
# edit_student GET    /students/:id/edit(.:format) students#edit
#      student GET    /students/:id(.:format)      students#show
#              PATCH  /students/:id(.:format)      students#update
#              PUT    /students/:id(.:format)      students#update
#              DELETE /students/:id(.:format)      students#destroy
#         root GET    /                            welcome#index
#        login GET    /login(.:format)             sessions#new
#              POST   /login(.:format)             sessions#create
#       logout GET    /logout(.:format)            sessions#destroy
#       signup GET    /signup(.:format)            students#new


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
