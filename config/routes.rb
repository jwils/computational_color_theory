Surveyapp::Application.routes.draw do
  resources :experiments

  #todo
  match 'experiments/:id/launch_experiment' => 'experiments#launch_exp'
  match 'questions/:id1/:id2' => 'questions#show'
  match 'experiments/:id/results' => 'experiments#get_results', :as => 'exp_results'

  resources :surveys
  resources :responses
    resources :surveys, :except => [:new, :create]
    resources :quizzes
    resources :questions
    resources :images

  root :to => 'demo#show'
end
