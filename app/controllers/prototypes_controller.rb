class PrototypesController < ApplicationController

  before_action :move_to_index, except: :index
  before_action :set_prototype, only: [:show]

  def index
    @prototypes = Prototype.eager_load(:user, :prototype_images).order("prototypes.created_at DESC")
  end

  def new
    @prototype = Prototype.new
    # ↓後でmainとsubでbuild方法を変数に入れ直して、fields_forの第二引数に入れて区別する必要あり
    # 理由としては、デフォルトで何かしらで画像が入っていないと、特にサブの場合変わったviewになる
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
