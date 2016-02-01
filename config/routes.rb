Rails.application.routes.draw do
  
  root 'public#index'

  get 'view/:event_url', :to => 'public#show'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'
  get    'lounge'  => 'public#lounge2'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :orders
  resources :events do
    resources :days do
      resources :sub_events
    end
    resources :tickets
    get 'schedule' => 'events#schedule'
  end

end
