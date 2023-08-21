Rails.application.routes.draw do
  resources :keys, only: %i[index destroy] do
    member do
      put 'unblock'
      put 'preserve'
    end

    collection do
      put 'generate'
      put 'show_random_unblocked'
    end
  end
end
