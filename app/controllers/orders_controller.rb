class OrdersController < ApplicationController
  before_action :logged_in?

  def index

  end

  def create
    puts params
    @user = current_user
    @product = Event.find_by(id: params[:event_id])
    @amount = @product.price
    @stripe_amount = (@amount * 100).to_i
    begin
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Participer à l'evenement",
      currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to orders_new_path
    end
    add_participation(@user.id, @product.id, customer.id)
    render :create
  end
end
