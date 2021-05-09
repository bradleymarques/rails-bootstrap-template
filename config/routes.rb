Rails.application.routes.draw do
  devise_for :users
  get "dashboard", to: "dashboards#show"
  root to: "pages#home"
end
