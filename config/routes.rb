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
  put '/cohorts/:id/follow/:provider' => 'cohorts#follow_cohort', as: :follow_cohort
  delete '/cohorts/:id/unfollow/:provider' => 'cohorts#unfollow_cohort', as: :unfollow_cohort

  #cohorts crud
  post '/cohorts/:id/scrape' => 'cohorts#scrape', as: :scrape_cohort
  resources :cohorts




end