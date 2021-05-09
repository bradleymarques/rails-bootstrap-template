Rails.application.routes.draw do
  get "license", to: "pages#license"
  root to: "pages#home"
end
