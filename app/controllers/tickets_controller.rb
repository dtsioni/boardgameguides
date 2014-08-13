class TicketsController < ApplicationController
  #TICKET IS REQUEST
  #REQUEST IS TICKET
  before_action :set_game, only: [:set_ticket, :new, :create]
  before_action :set_ticket, only: []
  authorize_resource

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new()
  end

  def index
    @tickets = Ticket.all
    #sort by score (votes)
  end

  def create
    #add to games and users, and give foreign ids
    @ticket = current_user.tickets.new(ticket_params)
    @ticket.game_id = @game.id
    @ticket.user_id = current_user.id    
    @game.tickets << @ticket
    #set other necessary variables within ticket
    @ticket.fulfilled = false
    @ticket.status = "Not being worked on"
    respond_to do |format|
      if @ticket.save
        format.html{ redirect_to @game}
        flash[:success] = "Ticket was successfully created!"
      else
        format.html{ render :new }
        flash.now[:error] = "Ticket was not created."
      end
    end
  end
  #edit and update don't "set ticket"
  #because the route isn't nested in game
  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    @game = Game.find(@ticket.game_id)
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html{ redirect_to @game }
        flash[:success] = "Ticket was successfully updated!"
      else
        format.html{ render :edit }
        flash.now[:error] = "Ticket was not successfuly updated."
      end
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    name = @ticket.name
    game = @ticket.game
    @ticket.destroy
    respond_to do |format|
      format.html{ redirect_to game, notice: "#{name} was successfully destroyed."}
    end
  end




  private

    def set_ticket
      @ticket = @game.tickets.find(params[:id])
    end

    def set_game
      @game = Game.find(params[:game_id])
    end

    def ticket_params
      params.require(:ticket).permit(:body, :status, :fulfilled, :name)
    end
  
end