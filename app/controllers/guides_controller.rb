class GuidesController < ApplicationController
  before_action :set_guide, only: [:show, :edit, :update, :destroy]
  before_action :set_game, only: [:new, :create]
  authorize_resource
  skip_authorize_resource only:[:show, :index]

  def show
  end

  def new
    @guide = Guide.new()
  end

  def create
    @guide = current_user.guides.new(guide_params)
    @game.guides << @guide

    respond_to do |format|
      if @guide .save
        format.html{ redirect_to @guide }
        flash[:success] = "Guide was successfully created!"
      else
        format.html{ render :new }
        flash.now[:error] = "Guide was not created."
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @guide.update(guide_params)
        format.html{ redirect_to @guide }
        flash[:success] = "Guide was successfully updated!"
      else
        format.html{ redirect_to edit_guide_path(@guide) }
        flash[:error] = "Guide was not successfully updated."
      end
    end
  end

  def index
    @guides = Guide.all
  end

  def destroy
    name = @guide.name
    @guide.destroy
    respond_to do |format|
      format.html{redirect_to control_path }
      flash[:success] = "#{name} was successfully destroyed."
    end
  end

  private
    def set_guide
      @guide = Guide.find(params[:id])
    end
    def set_game
      @game = Game.find(params[:game_id])
    end
    def guide_params
      params.require(:guide).permit(:name, :body, :format, :link)
    end

  #continuing to model guides
  #messing with formatting on guide show page
  #trying to use redcarpet to evaluate text as html
end