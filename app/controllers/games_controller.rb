class GamesController < ApplicationController

  before_action :set_game, only:[:show, :destroy, :edit, :update]
  authorize_resource
  skip_authorize_resource only:[:show, :index]

  def show
    @vote = Vote.new
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    respond_to do |format|
      if @game.save
        format.html{redirect_to @game}
        flash[:success] = "Game was successfully created!"
      else
        format.html{render :new}
        flash.now[:error] = "Game was not created"
      end
    end
  end

  def index
    @games = Game.all
    @games.to_a.sort_by!{ |m| m.name.downcase }
    #controller actions here are mirrored on home page
  end

  def destroy
    name = @game.name

    @game.tickets.each do |ticket|
      ticket.destroy
    end

    @game.guides.each do |guide|
      guide.destroy
    end
    
    @game.destroy
    respond_to do |format|
      format.html{ redirect_to control_path }
      flash[:success] = "#{name} was successfully destroyed."
    end
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game }
        flash[:success] = "Game was successfully updated!"
      else
        format.html { render :edit }
        flash.now[:error] = "User was not successfully updated."
      end
    end
  end 

  private

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name, :body, :fulfilled)
    end

end

