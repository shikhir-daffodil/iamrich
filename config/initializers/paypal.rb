PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger
PAYPAL_RETURN_URL = "http://localhost:3000/v1/api/paypal_execute"
PAYPAL_CANCEL_URL = "http://localhost:3000/v1/api/get_rank"
GOLD_COIN_PRICE = 20000
