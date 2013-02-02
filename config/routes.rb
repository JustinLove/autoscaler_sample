AutoscalerSample::Application.routes.draw do
  resources :jobs, :only => [:index, :create]
  root :to => 'jobs#index'
end
