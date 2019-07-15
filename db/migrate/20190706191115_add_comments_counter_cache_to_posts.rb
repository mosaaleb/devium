class AddCommentsCounterCacheToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false

    Post.reset_column_information
    Post.find_each do |article|
      article.update(comments_count: article.comments.count)
    end
  end
end
