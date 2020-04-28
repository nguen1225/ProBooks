require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
  describe "お問い合わせメール送信機能" do
    let(:contact) { create :contact }
    let(:mail) { ContactMailer.contact_mail(contact) }

    it 'メールが送信されること' do
      expect do
        mail.deliver_now
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it '内容が正しいこと' do
      expect(mail.subject).to eq 'お問い合わせいただきありがとうございます'
    end
    it 'メールのドメインが正しいこと' do
      expect(mail.from).to eq ["noreply@probooks.work"]
    end
  end
end
