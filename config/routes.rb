Rails.application.routes.draw do
  scope module: 'api' do
    namespace :v1 do
      resources :users, only: [:create, :index]
    end
  end
end
