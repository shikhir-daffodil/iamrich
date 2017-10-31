require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class V1::ApiController < ApplicationController
  
  def get_rich_people
    test = '{"rich_people": [{"name": "Shikhir","points": 1000,"rank": 1},{"name": "Saurabh","points": 999,"rank": 2},{"name": "Priyatosh","points": 998,"rank": 3},{"name": "Johari","points": 997,"rank": 4}]}'
    json_response(test, :ok)
  end

  def get_rank
    abort(parama.inspect.to_s)
  end

  def buy_coins
  	quantity = params[:quantity].to_i
  	gcprice = GOLD_COIN_PRICE.to_i
    @payment = Payment.new({
		  :intent =>  "sale",

		  # ###Payer
		  # A resource representing a Payer that funds a payment
		  # Payment Method as 'paypal'
		  :payer =>  {
		    :payment_method =>  "paypal" },

		  # ###Redirect URLs
		  :redirect_urls => {
		    :return_url => PAYPAL_RETURN_URL,
		    :cancel_url => PAYPAL_CANCEL_URL},

		  # ###Transaction
		  # A transaction defines the contract of a
		  # payment - what is the payment for and who
		  # is fulfilling it.
		  :transactions =>  [{

		    # Item List
		    :item_list => {
		      :items => [{
		        :name => "Gold Coin",
		        :sku => "gcoin",
		        :price => "#{gcprice}",
		        :currency => PAYPAL_CURRENCY,
		        :quantity => quantity }]},

		    # ###Amount
		    # Let's you specify a payment amount.
		    :amount =>  {
		      :total =>  "#{gcprice * quantity}",
		      :currency =>  PAYPAL_CURRENCY },
		    :description =>  "This is the payment transaction description." }]})

		# Create Payment and return status
		if @payment.create
		  # Redirect the user to given approval url
		  @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
		  logger.info "Payment[#{@payment.id}]"
		  logger.info "Redirect: #{@redirect_url}"
		else
		  logger.error @payment.error.inspect
		end
		redirect_to @redirect_url
  end

  def paypal_execute
  	payment_id = params[:paymentId]
  	payer_id = params[:PayerID]
    begin
    	payment = Payment.find(payment_id)
	    if payment.execute( :payer_id => payer_id )
	      json_response("payment success", :ok)
	    else
	      payment.error # Error Hash
	    end
	  rescue
	  	raise "Error processing"
	  end
  end

  def create_user
  	data = params
  	user = User.find_by(fbid: data.id)
  	if user.empty?
	  	user = User.new

	  	user.fbid = data.id
	  	user.fblogin = true

	  	if data.key?("first_name")
	  		user.first_name = data.first_name
	  	end

	  	if data.key?("last_name")
	  		user.last_name = data.last_name
	  	end

	  	if data.key?("gender")
	  		user.gender = data.gender
	  	end

	  	if data.key?("locale")
	  		user.locale = data.locale
	  	end

	  	if data.key?("picture")
	  		user.picture_url = data.picture.data.url
	  	end
	  	user.coins = 0

	  	user.save
	  end
  	json_response(user, :ok)
  end

end
