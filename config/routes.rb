Rails.application.routes.draw do
  
  resources :attempts
  resources :lessons
  get 'test_papers/upload', to: 'test_papers#upload'
  post 'test_papers/upload/', to: 'test_papers#parse'
  get 'test_papers/upload/show/', to: 'test_papers#show_uploaded'
  resources :test_papers

  resources :objectives do 
    resources :objective_states
  end

  resources :questions do 
    resources :answers
  end

  resources :module_packs

  resources :units

  resources :set_groups

  resources :topics

  resources :arcticles
  resources :subjects

  root 'subjects#index'
  resources :improvements
  resources :reviews
  resources :dashboard

  get 'improvements/:id/add_review' => 'improvements#add_review', as: :add_review
  get ':id/set_user_as_teacher' => 'improvements#set_user_as_teacher', as: :set_user_as_teacher
  get ':id/set_user_as_student' => 'improvements#set_user_as_student', as: :set_user_as_student
  get '/test/:id', to: 'objectives#test'


  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
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
  
  #->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
    get    "login"   => "users/sessions#new",         as: :new_user_session
    post   "login"   => "users/sessions#create",      as: :user_session
    delete "signout" => "users/sessions#destroy",     as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",    as: :new_user_registration
    post   "signup"  => "users/registrations#create", as: :user_registration
    put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

end
