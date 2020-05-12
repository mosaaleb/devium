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

  describe '#create_mention' do
    let(:mentioner) { create :user }
    let(:mentioned) { create :user }

    before do
      described_class.create(content: 'Just a post', user: mentioner)
    end

    it 'returns nil if mentionable does not contain @ sign' do
      expect(mentionable.send(:create_mention)).to eq nil
    end

    it 'create mentions for mentioned users' do
      mentioner.posts.create(content: "hi @#{mentioned.username}!")

      expect(mentioned.mentions.count).to eq 1
    end
  end
end
