class ExampleMailer < ApplicationMailer

  def sample_email user, current_order
    @user = user
    @current_order = current_order
    @line_items = @current_order.line_items
    mail(to: user.email, subject: Settings.app_name)
  end

end
