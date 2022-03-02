Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, shallow: true do
    resources :answers, shallow: true, except: %i[index show]
  end
end
