PaperTrailViewer::Engine.routes.draw do
  root to: 'viewer#index'
  resource :js, only: :show, defaults: { format: :js }
  resources :versions, only: %i[index update]
end
