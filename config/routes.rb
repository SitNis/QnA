require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
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

  concern :commentable do
    member do
      post :comment
    end
  end

  resources :questions, concerns: [:votable, :commentable] do
    resources :answers, concerns: [:votable, :commentable], shallow: true, except: %i[show index] do
      member do
        patch :best
      end
    end

    member do
      post :subscribe
      delete :unsubscribe
    end
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end

      resources :questions, except: %i[new edit] do
        resources :answers, except: %i[new edit], shallow: true
      end
    end
  end

  mount ActionCable.server => '/cable'
end
