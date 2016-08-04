class PrototypesController < ApplicationController

  before_action :move_to_index, except: :index
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.eager_load(:user, :prototype_images).order("prototypes.created_at DESC")
  end

  def new
    @prototype = Prototype.new
    @main_content = @prototype.prototype_images.build
    @sub_contents = 2.times { @prototype.prototype_images.build }
  end

  def show
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'Saved prototype successfully'
    else
      render :new, alert: 'Sorry, but something went wrong'
    end
  end

  def edit
    @main_content = @prototype.prototype_images.main
    @sub_contents = @prototype.prototype_images.sub
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to root_path, notice: 'Updated prototype successfully'
    else
      redirect_to edit_prototype_path, alert: 'All forms can\'t be blank'
    end
  end

  private
    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

    def prototype_params
      params.require(:prototype).permit(
        :title,
        :catch_copy,
        :concept,
        prototype_images_attributes: [:id, :content, :role]
      )
    end

    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

end
