class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    case user.role
    when "admin"

      can :destroy, User
      can :update, User
      can :index, User

      can :destroy, Game
      can :update, Game
      can :index, Game

    when "moderator"

      can :update, User

      can :destroy, Game
      can :update, Game
      can :index, Game


    when "author"      
      #can update self   

      can :update, User do |this_user|
        this_user.id == user.id
      end
      can :show, User

    when "guest"

    else

    end

  end

end