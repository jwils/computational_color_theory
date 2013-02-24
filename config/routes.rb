Surveyapp::Application.routes.draw do
  resources :experiments


  resources :surveys
  resources :responses
    resources :surveys, :except => [:new, :create]
    resources :quizzes
    resources :questions
    resources :images

  root :to => 'welcome#index'
end
