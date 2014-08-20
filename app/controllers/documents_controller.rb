class DocumentsController < ApplicationController
  before_action :set_game, only:[:show, :new, :create, :index, :update]
  before_action :set_document, only:[:show, :edit, :update, :destroy]
  authorize_resource
  skip_authorize_resource only: [:show]

  def show
  end

  def new
    @document = Document.new
  end

  def index
    @documents = Document.all
  end

  def create
    @document = current_user.documents.new(document_params)
    @document.game_id = @game.id
    @document.user_id = current_user.id
    @game.documents << @document
    respond_to do |format|
      if @document.save
        format.html{ redirect_to game_document_path(@game, @document) }
        flash[:success] = "Document was successfully created!"
      else
        format.html{ render :new }
        flash.now[:error] = "Document was not created."
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html{ redirect_to @document }
        flash[:success] = "Document was successfully updated!"
      else
        format.html{ render :edit }
        flash.now[:error] = "Document was not successfully updated."
      end
    end
  end

  def destroy
    name = @document.name
    game = @document.game
    @document.destroy
    respond_to do |format|
      format.html{ redirect_to game }
      flash[:success] = "#{name} was successfully destroyed."
    end
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end
    def set_document
      @document = Document.find(params[:id])
    end
    def document_params
      params.require(:document).permit(:name, :link, :format)
    end
end