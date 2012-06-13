Todos::Application.routes.draw do

  match '/auth/:provider/callback', to: "sessions#new" 
  match '/auth/failure', to:  'sessions#failure'

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    get "welcome/index"
    get  "logout"   => "sessions#destroy", :as => "logout"
    get  "login"    => "sessions#new",     :as => "login"
    post "login"    => "sessions#create",  :as => "login"
    get  "signup"   => "users#new",        :as => "signup"
    get  "profile"  => "users#show",       :as => "profile"
    
    
    resources :sessions
    resources :users
    resources :tasks
    resources :reset_passwords

    root :to => 'welcome#index'
  end
  
  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| 
    !req.path.starts_with? "/#{I18n.default_locale}/" and !req.path.starts_with? "/auth/"
  }
  match '', to: redirect("/#{I18n.default_locale}")
end
