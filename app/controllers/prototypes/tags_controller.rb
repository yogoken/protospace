class Prototypes::TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @prototypes = Prototype.tagged_with(@tag).eager_load(:user, :prototype_images).page(params[:page])
  end
end
