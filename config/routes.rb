Rails.application.routes.draw do
  root :to => 'flights#index'
  resources :users, :only => [:new, :create, :edit, :index, :show]
  resources :airlines, :only => [:index]
  resources :flights, :only => [:index, :show]
  resources :tickets, :only => [:show]
  post '/tickets/:id' => 'tickets#complete'
  get '/tickets/:id/cancel' => 'tickets#cancel', :as => 'cancel'
  post '/tickets/:id/cancel' => 'tickets#unlink', :as => 'unlink'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
end
