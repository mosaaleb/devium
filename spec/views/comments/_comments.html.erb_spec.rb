# frozen_string_literal: true

require 'rails_helper'

describe 'comments/_comment.html.erb', type: :view do
  let(:comment) { create :comment }

  before do
    assign(:comment, comment)
  end

  context 'when comment.user is not equal to current_user' do
    it 'renders delete comments button' do
      render partial: 'comments/comment.html.erb', locals: { comment: comment }

      expect(rendered).not_to have_selector('.delete-comment-button')
    end

    it 'renders edit comments button' do
      render partial: 'comments/comment.html.erb', locals: { comment: comment }

      expect(rendered).not_to have_selector('.edit-comment-button')
    end
  end

  context 'when comment.user equals current_user' do
    before do
      sign_in comment.user
    end

    it 'renders delete comments button' do
      render partial: 'comments/comment.html.erb', locals: { comment: comment }

      expect(rendered).to have_selector('.dropdown .comment-delete-button')
    end

    it 'renders edit comments button' do
      render partial: 'comments/comment.html.erb', locals: { comment: comment }

      expect(rendered).to have_selector('.dropdown .comment-edit-button')
    end
  end
end
