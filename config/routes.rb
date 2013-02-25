Surveyapp::Application.routes.draw do
  resources :experiments

  #todo
  match 'experiments/:id/launch_experiment' => 'experiments#launch_exp'

  resources :surveys
  resources :responses
    resources :surveys, :except => [:new, :create]
    resources :quizzes
    resources :questions
    resources :images

  root :to => 'welcome#index'
end
