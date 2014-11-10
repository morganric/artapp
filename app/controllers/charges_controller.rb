class ChargesController < ApplicationController

	def new
end

def create
  # Amount in cents
  @amount = params[:amount].to_i * 100
  @fee = @amount * 0.1
  @piece = Piece.find(params[:id])

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create({
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
    #,
    #:application_fee => @fee.to_i
  }
   # , 
   # @piece.user.stripe_secret_key
  )

  @piece.sold = true
  @piece.save

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
end
