Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#new"

  resource :session, only: [:create, :destroy, :index]

  resources :users, except: [:destroy], shallow: true do

    resources :friendings, only: [:create, :destroy, :index], shallow: true
    resources :photos, except: [:edit, :update], shallow: true


    resources :posts, only: [:index, :create, :destroy], shallow: true do
        resources :comments, only: [:create, :destroy], shallow: true do
          resources :likes, only: [:destroy, :create], defaults: {likeable: "Comment"}

        end
        resources :likes, only: [:create], defaults: {likeable: "Post"}
        delete "/post-like" => "likes#destroy", as: :post_like, defaults: {likeable: "Post"}
    end


  end



  get "/friends" => "static_pages#friends"
  get "/photos" => "static_pages#photos"
  get "/edit-profile" => "static_pages#edit_profile"


end
