Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :loan_simulations, only: [:create] do
        collection do
          post :bulk
        end
      end
    end
  end
end
