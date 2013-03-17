StarterApp::Application.routes.draw do

  match 'sign_in' => 'users/sessions#create', :via => :post, :as => 'sign_in'
  match 'sign_out' => 'users/sessions#destroy', :via => :delete, :as => 'sign_out'
  
  root :to => 'dashboards#show',
    :constraints => -> (r){ r.session[:user_id].present? } 
  root :to => 'users/sessions#new',
    :constraints => -> (r){ r.session[:user_id].blank? }  
end
