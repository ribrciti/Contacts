Rails.application.routes.draw do
 
  root "subjects#index"

  get 'admin', :to => "access#ndex"

  match ':controller(/:action(/:id))', :via => [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
end
