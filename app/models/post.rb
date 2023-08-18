class Post < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    has_many :comments, foreign_key: 'post_id'

    validate :no_comments_present_before_deletion, on: :destroy

  private

  def no_comments_present_before_deletion
    if comments.any?
      errors.add(:base, "Cannot delete post with comments.")
    end
  end
end
