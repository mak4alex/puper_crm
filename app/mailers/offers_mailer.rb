class OffersMailer < ApplicationMailer

  def distribute(offer)
    attachments['offer.xls'] = File.open(Rails.root.join('README.md'), 'r').read
    contact_email = offer.agent.contact.email
    subject = offer.type
    p '======================================'
    p contact_email.to_s
    p subject.to_s
    p '======================================'
    mail to: 'mak4alex@gmail.com', subject: subject
  end

end
