Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events do
        resources :screens do
          resource :playlist, except: [:index, :create] do
            resources :contents do
              member do
                post '/move_higher', to: 'contents#move_higher'
                post '/move_lower', to: 'contents#move_lower'
              end
            end
          end
        end
      end
    end
  end
end
