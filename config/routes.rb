Rails.application.routes.draw do
  get 'generate/index', as: 'generate_index'
  post 'generate/index'

  get 'admin', to: 'admin#index', as: 'admin'
  post 'admin_load_posts', to: 'admin#load_posts'
  post 'admin_delete_all_posts', to: 'admin#delete_all_posts'

  root 'generate#index'
end
