VysRails::Application.routes.draw do
  

  

  

  

  devise_for :users

  resources :forms
  resources :sessions
  
  
  get "login" => "sessions#new", :as => "login"

 

  root :to => 'a#index'

  match '/contact', :to => 'a#contact'
  match '/about',   :to => 'a#about'
  match '/404',    :to => 'a#404'
  match '/layout',  :to => 'a#layout'
  match '/people',  :to => 'a#people'
  match '/work',  :to => 'a#work'
  match '/hata',  :to => 'a#deneme'

end
  
 
 
 

  
