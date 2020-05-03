# frozen_string_literal: true

require 'rails_helper'

describe 'comments/_comment.html.erb', type: :view do
  let(:comment) { create :comment }

  before do
    assign(:comment, comment)
  end

  context 'when no logged in/logged in user is not the owner of the comment' do
    it 'does not renders delete comments button' do
      render partial: 'comments/comment.html.erb', locals: { comment: comment }

      expect(rendered).not_to have_selector('.delete-comment-button')
    end

    it 'does not renders edit comments button' do
      render partial: 'comments/comment.html.erb', locals: { comment: comment }

      expect(rendered).not_to have_selector('.edit-comment-button')
    end
  end

  context 'when logged in user is the owner of the comment' do
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
