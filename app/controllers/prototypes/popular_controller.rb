class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.order("prototypes.like_count DESC").eager_load(:user, :prototype_images)
    @status = 'popular'
  end
end
