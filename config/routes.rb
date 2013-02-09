Surveyapp::Application.routes.draw do
  resources :experiments


  resources :surveys, :only => :new

  namespace :admin do
    resources :responses
    resources :surveys, :except => :new
    resources :quizzes
    resources :questions
    resources :images
  end

  root :to => 'welcome#index'
end
