class Prototypes::CommentsController < ApplicationController
  before_action :set_prototype, only: [:create, :destroy]
  before_action :set_comments,  only: [:create, :destroy]

  def create
    @comment = @prototype.comments.create(comment_params)
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

  private
    def set_prototype
      @prototype = Prototype.find(params[:prototype_id])
    end

    def set_comments
      @comments = @prototype.comments.includes(:user, :prototype)
    end

    def comment_params
      params.require(:comment).permit(:user_id, :prototype_id, :content)
    end
end