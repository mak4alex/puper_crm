class OffersMailer < ApplicationMailer

  def distribute(offer)
    DealXlsxService.new(Rails.root.join('tmp', 'export.xlsx')).export(offer.deal)
    attachments['offer.xlsx'] = File.open(Rails.root.join('tmp', 'export.xlsx'), 'r').read
    contact_email = offer.agent.contact.email
    subject = offer.type
    p '======================================'
    p contact_email.to_s
    p subject.to_s
    p '======================================'
    mail to: 'mak4alex@gmail.com', subject: subject
  end

end
