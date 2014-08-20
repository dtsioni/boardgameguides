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

      can :new, Guide
      can :create, Guide
      can :edit, Guide
      can :update, Guide
      can :destroy, Guide

      can :new, Document
      can :create, Document
      can :edit, Document
      can :update, Document
      can :destroy, Document



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

      can :new, Guide
      can :create, Guide
      can :edit, Guide
      can :update, Guide
      can :destroy, Guide

      can :new, Document
      can :create, Document
      can :edit, Document
      can :update, Document
      can :destroy, Document

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

      can :new, Guide
      can :create, Guide
      can :edit, Guide do |this_guide|
        this_guide.user_id == user.id
      end
      can :update, Guide do |this_guide|
        this_guide.user_id == user.id
      end

      can :new, Document
      can :create, Document
      can :edit, Document do |this_doc|
        this_doc.user_id == user.id
      end
      can :update, Document do |this_doc|
        this_doc.user_id == user.id
      end
      can :destroy, Document do |this_doc|
        this_doc.user_id == user.id
      end
    else
      user.role = "guest"
    end

  end

end