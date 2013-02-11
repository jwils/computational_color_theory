Surveyapp::Application.routes.draw do
  resources :experiments


  resources :surveys

  namespace :admin do
    resources :responses
    resources :surveys, :except => [:new, :create]
    resources :quizzes
    resources :questions
    resources :images
  end

  root :to => 'welcome#index'
end
