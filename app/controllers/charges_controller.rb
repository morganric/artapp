class ChargesController < ApplicationController

	def new
end

def create
  # Amount in cents
  @amount = params[:amount].to_i * 100
  @fee = @amount * 0.1

  if params[:id] != nil
    @piece = Piece.find(params[:id])
    Stripe.api_key = @piece.user.stripe_secret_key
  end

  if params[:profile_id] != nil
  @profile = Profile.find(params[:profile_id])
  Stripe.api_key = @profile.user.stripe_secret_key
  end

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create({
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd',
    :application_fee => @fee.to_i
  }, 
   Stripe.api_key
  )

  if params[:id] != nil
    @piece.sold = true
    @piece.save
  end

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
end
