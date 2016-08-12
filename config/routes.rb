Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#new"

  resource :session, only: [:create, :destroy]

  resources :users, except: [:destroy, :index], shallow: true do
    resources :posts, only: [:index, :create, :destroy], shallow: true do
        resources :comments, only: [:create, :destroy], shallow: true

    end
  end


  get "/about" => "static_pages#about"
  get "/friends" => "static_pages#friends"
  get "/photos" => "static_pages#photos"
  get "/edit-profile" => "static_pages#edit_profile"


end
