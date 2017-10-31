Rails.application.routes.draw do
  namespace :v1 do
    get 'api/get_rich_people'
    get 'api/get_rank'
    get 'api/buy_coins'
    get 'api/paypal_execute'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
