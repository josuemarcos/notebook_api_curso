Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :logins, only: [:create]
  resources :kinds, only: %i[index show] #desabilatas funções CREATE, UPDATE e DELETE, pois ainda falta o usuário admin ser implementado
  resources :contacts do
    #resource :kind, only: [:show]
    resource :kind, only: [:show], path: "relationships/kind"    

    
    resources :phones

    resource :address

    collection do
      get :search
    end
  
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
