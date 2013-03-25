StarterApp::Application.routes.draw do

  resources :users do
    collection do
      delete 'destroy_multiple'
    end
  end
 
  match 'sign_in' => 'users/sessions#create', :via => :post, :as => 'sign_in'
  match 'sign_out' => 'users/sessions#destroy', :via => :delete, :as => 'sign_out'
  
  root :to => 'dashboards#show',
    :constraints => -> (r){ r.session[:user_id].present? } 
  root :to => 'users/sessions#new',
    :constraints => -> (r){ r.session[:user_id].blank? }  

  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
end
