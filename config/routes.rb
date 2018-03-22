Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/excel_sample/signages'
  get '/excel_sample/shops'

  constraints(Domain::Api) do
    namespace :api do
      namespace :v1 do
        resources :signages, only: [:show] do
          scope module: :signages do
            member do
              resource :status, only: [:create]
              resource :token, only: [:create]
              resource :probe, only: [:show]
            end
          end
        end

        resources :signage_ad_units, only: [:show]
      end

      namespace :v2 do
        resources :signages, only: [:show]
      end
    end
  end


  constraints(Domain::Signage) do
    get '/', to: 'client/dashboards#index'

    scope module: :client, as: 'client' do
      resources :signages do
        scope module: 'signages' do
          resource :publish, only: [:create]

          collection do
            resource :excel_upload, only: [:create]
          end
        end
      end

      resources :shops do
        scope module: 'shops' do
          resource :publish, only: [:create]

          collection do
            resource :excel_upload, only: [:create]
          end
        end
      end

      resources :containers do
        scope module: :containers do
          resource :publish, only: [:create]
          resource :content, only: [:show, :create]
          resource :image, only: [:show, :create, :destroy]
        end
      end

      resources :ad_templates

      concern :status_actions do
        resource :pause, only: [:create]
        resource :resume, only: [:create]
      end

      resources :signage_ad_units do
        scope module: :signage_ad_units do
          concerns :status_actions
          resources :template_ads, only: [:index]
        end
      end

      resources :managers do
        scope module: :managers do
          concerns :status_actions
          resource :transaction_histories, only: [:show]
        end
      end

      resources :campaigns do
        scope module: :campaigns do
          concerns :status_actions
        end
      end

      resources :ad_groups do
        scope module: :ad_groups do
          concerns :status_actions
        end
      end

      resources :ads do
        scope module: :ads do
          concerns :status_actions
        end
      end

      namespace :reports do
        resources :ads, only: [:index, :create]
        resources :shops, only: [:index, :create]
        resources :signages, only: [:index, :create]
        resources :managers, only: [:index, :create]
      end

      resources :materials

      resource :form_datas, only: [] do
        collection do
          get :ads
          get :ad_groups
        end
      end
    end
  end

  constraints(Domain::Signage) do
    get '/admin', to: 'admin/dashboards#index'

    namespace :admin do
      scope module: 'signage_debugs' do
        resources :apks, only: [:index ,:create]
      end

      resources :signages do
        scope module: 'signages' do
          resource :publish, only: [:create]

          collection do
            resource :excel_upload, only: [:create]
          end
        end
      end

      resources :shops do
        scope module: 'shops' do
          resource :publish, only: [:create]

          collection do
            resource :excel_upload, only: [:create]
          end
        end
      end

      resources :containers do
        scope module: :containers do
          resource :publish, only: [:create]
          resource :content, only: [:show, :create]
          resource :image, only: [:show, :create, :destroy]
        end
      end

      resources :ad_templates do
        scope module: :ad_templates do
          resource :copy, only: [:create]
        end
      end

      resources :templates do
        scope module: :templates do
          resource :copy, only: [:create]
        end
      end
      resources :clients
      resources :users

      concern :status_actions do
        resource :pause, only: [:create]
        resource :resume, only: [:create]
      end

      resources :signage_ad_units do
        scope module: :signage_ad_units do
          concerns :status_actions
          resources :template_ads, only: [:index]
        end
      end

      resources :managers do
        scope module: :managers do
          concerns :status_actions
          resource :transaction_histories, only: [:show]
        end
      end

      resources :campaigns do
        scope module: :campaigns do
          concerns :status_actions
        end
      end

      resources :ad_groups do
        scope module: :ad_groups do
          concerns :status_actions
        end
      end

      resources :ads do
        scope module: :ads do
          concerns :status_actions
        end
      end

      resources :materials

      namespace :reports do
        resources :ads, only: [:index, :create]
        resources :shops, only: [:index, :create]
        resources :signages, only: [:index, :create]
        resources :managers, only: [:index, :create]
      end

      resource :form_datas, only: [] do
        collection do
          get :ads
          get :ad_groups
        end
      end
    end
  end

  constraints(Domain::Adsignage) do
    get '/admin', to: 'adsignage/dashboards#index'

    namespace :adsignage do

    end
  end

end
