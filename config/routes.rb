Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contents
      resources :events do
        resources :screens do
          resource :playlist
        end
      end
    end
  end
end
