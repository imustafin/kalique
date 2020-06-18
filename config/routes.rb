Rails.application.routes.draw do
  get 'generate/index'
  post 'generate/index'


  root 'generate#index'
end
