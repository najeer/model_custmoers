ModelCustmoers::Application.routes.draw do
  resources :customers do
    collection do
       post :import 
       get :inactive
       post :inactive       
     end
     member do
       get :deactive
       get :activate
      end
    resources :addresses
    resources :notes
    resources :contacts
  end
  resources :users do
    collection do
      get :forgot_password  
      post :forgot_password
      get :edit_password
      put  :edit_password
      get :inactive
      post :inactive
    end 
     member do
       get :deactive
       get :activate
      end
  end
    resources :addresses
    
    resources :contacts do
      resources :addresses
    end

    resources :notes

   resources :sessions
   root :to => 'sessions#new'
   match 'logout' => 'sessions#destroy', :as => :logout
  
end
