Rails.application.routes.draw do
  resources :questions, shallow: true do
    resources :answers, shallow: true, except: %i[index show]
  end
end
