Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :files, only: %i[destroy]
  resources :links, only: %i[destroy]
  resources :badges, only: %i[ index ]

  concern :votable do
    member do
      post :like
      post :dislike
      delete :cancel_vote
    end
  end

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, shallow: true, except: %i[show index] do
      member do
        patch :best
      end
    end
  end

  mount ActionCable.server => '/cable'
end
