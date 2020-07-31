Rails.application.routes.draw do
  get 'generate/index'
  post 'generate/index'

  get 'admin', to: 'admin#index', as: 'admin'

  root 'generate#index'
end
