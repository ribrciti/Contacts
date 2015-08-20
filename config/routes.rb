Rails.application.routes.draw do
 
  
  get 'sections/index'

  get 'sections/show'

  get 'sections/new'

  get 'sections/edit'

  get 'sections/delete'

	root "subjects#index"

	get 'pages/index'

	match ':controller(/:action(/:id))', :via => [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
end
