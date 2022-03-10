Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true, except: %i[show index] do
      member do
        patch :best
      end
    end
  end
end
