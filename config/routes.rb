Rails.application.routes.draw do
  root 'page#index'
  get 'page/index'
  
  get 'authorize' => 'auth#gettoken'
  
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy' 

  resources :users do
    resources :projects, only: [:index, :create, :show, :destroy] do
      get 'search', on: :member
      resources :features, only: [:create, :destroy] do
        resources :tasks, only: [:create, :destroy]
        resources :documents, only: [:create, :show, :destroy]
        resources :comments, only: [:create, :destroy]
      end  
    end
  end

  patch '/features/:id/update_status', to: 'features#update_status'
  patch '/features/:id', to: 'features#update_member'

  post '/tasks/:id/update_task', to: 'tasks#update_task'

  get 'notifications/show'

  mount ActionCable.server =>'/cable'
end
