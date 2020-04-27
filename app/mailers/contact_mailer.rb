class ContactMailer < ApplicationMailer
  default from: "hogehoge <noreply@probooks.work>"

  def contact_mail(contact)
    @contact = contact
    mail to: 'hikaru.fc0710@gmail.com',
         subject: 'メール機能開発用です'
  end
end
