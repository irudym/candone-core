Rails.application.routes.draw do
  scope module: :v1 do
    resources :persons, defaults: { format: :json }
    resources :person_types

    get '/tasks/analytic', to: 'tasks#analytic', defaults: { format: :json }
    resources :tasks, defaults: { format: :json }
    
    resources :notes, defaults: { format: :json }
    resources :projects, defaults: { format: :json }
  end
end
