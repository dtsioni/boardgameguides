class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    case user.role
    when "admin"

      can :destroy, User
      can :update, User
      can :index, User
      #SUPERVISE describes both ADMINS and MODERATORS
      can :supervise, :all

      can :destroy, Game
      can :update, Game
      can :index, Game
      can :new, Game
      can :create, Game

      can :new, Ticket
      can :create, Ticket
      can :show, Ticket
      can :index, Ticket
      can :edit, Ticket
      can :update, Ticket
      can :destroy, Ticket



    when "moderator"

      can :update, User
      #SUPERVISE describes both ADMINS and MODERATORS
      can :supervise, :all

      can :destroy, Game
      can :update, Game
      can :index, Game
      can :new, Game
      can :create, Game

      can :new, Ticket
      can :create, Ticket
      can :show, Ticket
      can :index, Ticket
      can :edit, Ticket
      can :update, Ticket
      can :destroy, Ticket


    when "author"      
      #can update self   

      can :update, User do |this_user|
        this_user.id == user.id
      end
      can :show, User

      can :index, Game
      can :new, Game
      can :create, Game

      can :new, Ticket
      can :create, Ticket
      can :show, Ticket
      can :index, Ticket

      can :edit, Ticket do |this_ticket|
        this_ticket.user_id == user.id
      end
      can :update, Ticket do |this_ticket|
        this_ticket.user_id == user.id
      end 
      can :destroy, Ticket do |this_ticket|
        this_ticket.user_id == user.id
      end

    when "guest"

    else

    end

  end

end