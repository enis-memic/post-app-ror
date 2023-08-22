require 'rails_helper'

describe Comment, type: :model do
  before :each do
    @author = User.new(name: 'Enis', email:'enis@gmail.com')
    @post = Post.new(author: @author, title: 'Post one', description: 'Post 1111111')

    @comment1 = Comment.create(author: @author, post: @post, text: 'Comment one')
    @comment2 = Comment.create(author: @author, post: @post, text: 'Comment two')
  end

  it 'will have the Posts comments_counter through update_comments_counter ' do
    expect(@post.comment_counter).to eq 2
  end
end