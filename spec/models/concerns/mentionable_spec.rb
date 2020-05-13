# frozen_string_literal: true

shared_examples 'mentionable' do
  subject(:mentionable) do
    FactoryBot.create(described_class.name.underscore.to_s)
  end

  it { is_expected.to have_many(:mentions) }

  it 'callback create mention after creation' do
    allow(mentionable).to receive(:create_mention)
    subject.run_callbacks(:create)
    expect(mentionable).to have_received(:create_mention)
  end

  context 'when creating mentions' do
    let(:mentioner) { create :user }
    let(:mentioned) { create :user }
    let(:mentioned_users) { create_list(:user, 2) }

    it 'returns nil if mentionable does not contain @ sign' do
      described_class.create(content: 'some content', user: mentioner)

      expect(mentionable.send(:create_mention)).to eq nil
    end

    it 'create mentions for mentioned user' do
      mentioner.posts.create(content: "hi @#{mentioned.username}!")

      expect(mentioned.mentions.count).to eq 1
    end

    it 'create metions for all mentioned users' do
      mentioner.posts.create(content: "@#{mentioned_users[0].username} "\
                                      "@#{mentioned_users[1].username}!")

      mentioned_users.each do |user|
        expect(user.mentions.count).to eq 1
      end
    end
  end
end
