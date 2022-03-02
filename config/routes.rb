Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events do
        resources :screens do
          resource :playlist, except: [:index, :create] do
            resources :contents
          end
        end
      end
    end
  end
end
