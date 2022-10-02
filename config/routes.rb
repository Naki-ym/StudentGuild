Rails.application.routes.draw do
  root 'home#top'

  get "login"    => "users#login_form"
  get "settings" => "users#settings"
  get "admin"    => "users#admin_settings"
  get "signup"   => "users#signup"
  post "login"   => "users#login"
  post "logout"  => "users#logout"
  post "signup"  => "users#create"

  get "users/:id"          => "users#show"
  get "users/:id/edit"     => "users#edit"
  patch "users/:id/update" => "users#update"
  post "users/:id/delete"  => "users#delete"

  get "users/:id/follows"          => "users#follows"
  get "users/:id/followers"        => "users#followers"
  post "users/:id/relationships"   => "relationships#create"
  delete "users/:id/relationships" => "relationships#destroy"

  get "timeline"           => "posts#timeline"
  get "posts/create"       => "posts#timeline"
  get "posts/:id"          => "posts#show"
  get "posts/:id/edit"     => "posts#edit"
  patch "posts/:id/update" => "posts#update"
  post "posts/create"      => "posts#create"
  post "posts/:id/delete"  => "posts#delete"

  post 'favorite/:id'        => 'favorites#create', as: 'create_favorite'
  post 'favorite/:id/delete' => 'favorites#delete', as: 'delete_favorite'
  
  get "chats"                       => "chats#top"
  get "chats/create"                => "chats#create"
  get "chats/:id"                   => "chats#room"
  get "chats/:id/edit"              => "chats#edit"
  post "chats/create"               => "chats#create_group"
  post "chats/crate/indibidual/:id" => "chats#crate_individual"
  post "chats/:id/create"           => "messages#create"
  post "chats/:id/delete"           => "chats#delete"
  post "chats/:id/update"           => "chats#update"

  get "projects"                => "projects#board"
  get "myprojects"              => "projects#myproject"
  get "projects/create"         => "projects#create_project"
  get "projects/:id"            => "projects#show"
  get "projects/:id/edit"       => "projects#edit"
  get "projects/:id/entry"      => "projects#entry_page"
  get "projects/:id/entries"    => "projects#entry_list"
  patch "projects/:id/update"   => "projects#update"
  post "projects/create"        => "projects#create"
  post "projects/:id/delete"    => "projects#delete"
  post "projects/:id/entry"     => "projects#entry"
  post "projects/:id/publish"   => "projects#publish"
  post "projects/:id/unpublish" => "projects#unpublish"

  match "dynamic_tag", to: 'projects#dynamic_tag', via: [:get, :post]

  get "tags"                         => "tags#list"
  get "tags/categories"              => "tags#category_list"
  get "tags/categories/create"       => "tags#create_category_form"
  get "tags/categories/:id/edit"     => "tags#category_edit"
  get "tags/create"                  => "tags#create_form"
  get "tags/:id/edit"                => "tags#edit"
  patch "tags/categories/:id/update" => "tags#category_update"
  patch "tags/:id/update"            => "tags#update"
  post "tags/create"                 => "tags#create"
  post "tags/categories/create"      => "tags#create_category"
  post "tags/categories/:id/delete"  => "tags#category_delete"
  post "tags/:id/delete"             => "tags#delete"

  match "sort_tag", to: 'tags#sort_tag', via: [:get]
  match "sort_tag_category", to: 'tags#sort_tag_category', via: [:get]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
