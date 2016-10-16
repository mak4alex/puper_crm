# Preview all emails at http://localhost:3000/rails/mailers/offers_mailer
class OffersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/offers_mailer/send
  def send
    OffersMailer.send
  end

end
