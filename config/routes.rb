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
  patch "users/:id/update" => "users#update"
  post "users/:id/delete" => "users#delete"

  get "timeline" => "posts#timeline"
  get "posts/create" => "posts#timeline"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/create" => "posts#create"
  patch "posts/:id/update" => "posts#update"
  post "posts/:id/delete" => "posts#delete"

  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  post 'favorite/:id/delete' => 'favorites#delete', as: 'delete_favorite'
  
  get "chats" => "chats#top"
  get "chats/create" => "chats#create"
  get "chats/:id" => "chats#room"
  get "chats/:id/edit" => "chats#edit"
  post "chats/create" => "chats#create_group"
  post "chats/crate/indibidual/:id" => "chats#crate_individual"
  post "chats/:id/update" => "chats#update"
  post "chats/:id/delete" => "chats#delete"
  post "chats/:id/create" => "messages#create"

  get "projects" => "projects#board"
  get "myprojects" => "projects#myproject"
  get "projects/create" => "projects#create_project"
  get "projects/:id" => "projects#show"
  get "projects/:id/entry" => "projects#entry_page"
  get "projects/:id/entries" => "projects#entry_list"
  post "projects/create" => "projects#create"
  post "projects/:id/publish" => "projects#publish"
  post "projects/:id/unpublish" => "projects#unpublish"
  post "projects/:id/entry" => "projects#entry"
  post "projects/:id/delete" => "projects#delete"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
