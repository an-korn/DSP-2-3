Rails.application.routes.draw do
  resources :dsps, only: %i(new create show)

  resources :fourier_transforms, only: %i(new create show)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dsps#new'
end
