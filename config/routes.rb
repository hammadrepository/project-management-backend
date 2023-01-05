Rails.application.routes.draw do
  resources :technologies
  resources :developers
  resources :projects
  post "/project/add-developer" => "projects#addDeveloper", :as => :add_developer
  post "/project/add-technology" => "projects#addTechnology", :as => :add_technology
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
