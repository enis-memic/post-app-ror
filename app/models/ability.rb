class Ability
    include CanCan::Ability
  
    def initialize(user)
      user ||= User.new
      if user.role == 'admin'
        can :manage, :all
      else
        can [:edit, :update], Post, author_id: user.id
      can :destroy, Post, author_id: user.id, comment_counter: 0
      can :destroy, Comment, author_id: user.id
      can :create, Post
      can :create, Comment
      can :read, :all
      end
    end
  end
  