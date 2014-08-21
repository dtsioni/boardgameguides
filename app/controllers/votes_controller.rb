class VotesController < ApplicationController
  def new
    @vote = Vote.new
    @tickets = Ticket.select('id, name').to_a
  end

  def create
    @vote = current_user.votes.new(vote_params)
    #if its an upvote, we need to remove previous downvotes
    if @vote.vote_type == "up"
      current_user.votes.each do |vote|
        #if the vote is not the same vote
        #and if the vote is a downvote
        #and if the vote is voting on the same ticket or guide
        if @vote.id != vote.id && (vote.vote_type == "down" && @vote.ticket_id == vote.ticket_id
          vote.destroy
        end
      end
    end
    #if downvote, remove previous upvotes
    if @vote.vote_type == "down"
      current_user.votes.each do |vote|
        #if the vote is not the same vote
        #and if the vote is a downvote
        #and if the vote is voting on the same ticket or guide
        if @vote.id != vote.id && vote.vote_type == "up" && @vote.ticket_id == vote.ticket_id
          #destroy vote
          vote.destroy
        end
      end
    end

    respond_to do |format|
      if @vote.save
        flash[:success] = "Vote successful"
        format.html{redirect_to @vote.ticket, notice: "Vote was successful."}
        format.js
      else
        flash[:error] = "Vote not successful"
        format.html {render :new}
        format.js
      end
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:vote_type, :ticket_id, :user_id, :guide_id)
    end
end