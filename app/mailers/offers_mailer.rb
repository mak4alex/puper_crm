class OffersMailer < ApplicationMailer

  def distribute(offer)
    #attachments['offer.xls'] = File.new
    contact_email = offer.agent.contact.email
    subject = offer.type
    p '======================================'
    p contact_email.to_s
    p subject.to_s
    p '======================================'
    mail to: contact_email, subject: subject
  end

end
