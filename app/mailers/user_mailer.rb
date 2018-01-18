class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_confirmation(order)
    @order = order
    @items = @order.line_items
    mail(to: @order.email, subject: "Order #@order.id has been received.")
  end

end