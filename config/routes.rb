Rails.application.routes.draw do
  
  resources :categories
    root to: 'pages#index'
    devise_for :users
    resources :notes 
    get '/task_list', to: 'notes#task_list'
    get '/report_list', to: 'notes#report_list'
    get '/personal_list', to: 'notes#personal_list'
   
 
end




