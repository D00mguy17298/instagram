class Ability
  include CanCan::Ability
  include Visible
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    return unless user.present?
    can :read, :all
    can :manage, Post, user_id: user.id
    return unless user.admin?
    can :manage, :all
  end
end