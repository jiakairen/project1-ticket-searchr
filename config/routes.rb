Rails.application.routes.draw do
  root :to => 'flights#index'
  resources :users, :only => [:new, :create, :edit, :index, :show, :update]
  resources :flights, :except => [:new, :create]
  resources :airlines do
    resources :flights, :only => [:new, :create] do
      resources :tickets, :only => [:new, :create]
    end
  end
  resources :tickets, :only => [:show]

  post '/tickets/:id' => 'tickets#complete'
  get '/tickets/:id/cancel' => 'tickets#cancel', :as => 'cancel'
  post '/tickets/:id/cancel' => 'tickets#unlink', :as => 'unlink'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
end
