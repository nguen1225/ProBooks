class ContactMailer < ApplicationMailer
  default from: 'probooks<noreply@probooks.work>'

  def contact_mail(contact)
    @contact = contact
    mail to: 'hikaru.fc0710@gmail.com',
         subject: 'お問い合わせいただきありがとうございます'
  end
end
