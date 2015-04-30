class CommentsController < ApplicationController

  def create
    @photo = Photo.find( params[:photo_id] )
    @comment = @photo.comments.build( comment_params )
    @comment.user = current_user

    @comment.save!

    redirect_to root_url
  end

  def destroy
    @comment = current_user.comments.find( params[:id] )
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js  # destroy.js.erb
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:content)
  end

end
