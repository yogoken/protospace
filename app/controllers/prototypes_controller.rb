class PrototypesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: :index
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.eager_load(:user, :prototype_images).order("prototypes.created_at DESC").page(params[:page])
    @status = 'newest'
  end

  def new
    @prototype = Prototype.new
    @main_content = @prototype.prototype_images.build
    @sub_contents = 2.times { @prototype.prototype_images.build }
  end

  def show
    @like = @prototype.likes
    @comment = Comment.new(prototype_id: @prototype_id)
    @comments = @prototype.comments.includes(:user).all
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'Saved prototype successfully'
    else
      # renderの際にgot: nilというエラーだったためredirect_toに変更した
      redirect_to new_prototype_path, alert: 'Sorry, but something went wrong'
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

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: 'Deleted prototype successfully'
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
      # 確認1 prototype.rbで定義したacts_as_taggableにより、prototype生成時に.merge(tag_list: )が利用することができる
      # それにより、prototypes/new.html.hamlで入力した値がparams[:prototype][:tag][:ここに入力した値が入る]なり、tagsテーブルに保存される
      ).merge(tag_list: params[:prototype][:tag])
    end

    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

end
