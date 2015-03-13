Rails328::Application.routes.draw do
  root :to => 'application#index'

  resources :changes, :controller => 'paper_trail_manager/changes'
  resources :entities
  resources :platforms

end
