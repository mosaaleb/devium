# frozen_string_literal: true

shared_examples 'mentionable' do
  it { is_expected.to have_many(:mentions) }
end
