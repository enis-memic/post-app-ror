require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'My Post', description:'Testing this post', comment_counter: 10) }

  before { subject.save }

  it 'Title should be present' do
    expect(subject.title).to eql('My Post')
  end

  it 'Description should be present' do
    expect(subject.description).to eql('Testing this post')
  end

  it 'Comment counter should be 0 or greater' do
    subject.comment_counter = -1
    expect(subject).to_not be_valid
  end
end

  describe '#recent_comments' do
    let(:post) do
      Post.create(title: 'Test Post', author: author, description:'Testing this post', comment_counter: 0)
    end
    let(:author) { User.create(name: 'Elli', email: 'elli@gmail.com') }

    let!(:comment1) { Comment.create(author: author, post: post, text: 'Comment one') }
    let!(:comment2) { Comment.create(author: author, post: post, text: 'Comment two') }
    let!(:comment3) { Comment.create(author: author, post: post, text: 'Comment three') }
    let!(:comment4) { Comment.create(author: author, post: post, text: 'Comment four') }
    let!(:comment5) { Comment.create(author: author, post: post, text: 'Comment five') }
    let!(:comment6) { Comment.create(author: author, post: post, text: 'Comment six') }

    it 'returns the most recent 5 comments' do
      expect(post.comment_counter).to eq(6)
    end
  end