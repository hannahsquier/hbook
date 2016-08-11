Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#home"

  resource :session

  get "/about" => "static_pages#about"
  get "/timeline" => "static_pages#timeline"
  get "/friends" => "static_pages#friends"
  get "/photos" => "static_pages#photos"
  get "/edit-profile" => "static_pages#edit_profile"


end
