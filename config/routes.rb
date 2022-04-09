Rails.application.routes.draw do
  root 'home#top'

  get "signup" => "users#signup"
  get "login" => "users#login_form"
  get "settings" => "users#settings"
  post "signup" => "users#create"
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/:id/delete" => "users#delete"

  get "timeline" => "posts#timeline"
  get "posts/create" => "posts#timeline"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/create" => "posts#create"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/delete" => "posts#delete"

  get "chats" => "chats#top"
  get "chats/create" => "chats#new"
  get "chats/:id" => "chats#room"
  get "chats/:id/edit" => "chats#edit"
  post "chats/crate" => "chats#crate"
  post "chats/crate/indibidual/:id" => "chats#crate_individual"
  post "chats/:id/update" => "chats#update"
  post "chats/:id/delete" => "chats#delete"

  post "chats/:id/crate" => "messages#crate"

  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  post 'favorite/:id/delete' => 'favorites#delete', as: 'delete_favorite'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
