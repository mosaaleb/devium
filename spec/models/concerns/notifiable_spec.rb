# frozen_string_literal: true

shared_examples 'notifiable' do
  subject(:notifiable) do
    FactoryBot.create(described_class.name.underscore.to_s)
  end

  it { is_expected.to have_many(:notifications) }

  it 'callback create notification after creation' do
    allow(notifiable).to receive(:create_notification)
    subject.run_callbacks(:create)
    expect(notifiable).to have_received(:create_notification)
  end

  context 'when creating notifications' do
    let(:recipients) { create_list(:user, 5) }
    let(:noti) { build(described_class.name.underscore.to_s) }

    before do
      allow(noti)
        .to receive(:notification_recipients)
        .and_return(recipients)

      noti.save
    end

    it 'create notifiaction for every recipient' do
      recipients.each do |recipient|
        expect(recipient.notifications.count).to eq 1
      end
    end

    it 'notifier type should be as the described_class' do
      recipients.each do |recipient|
        expect(recipient.notifications.first.notifier).to eq noti
      end
    end
  end
end
