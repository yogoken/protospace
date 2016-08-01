class PrototypesController < ApplicationController

  before_action :move_to_index, except: :index

  def index
  end

  def new
    @prototype = Prototype.new
    # ↓後でmainとsubでbuild方法を変数に入れ直して、fields_forの第二引数に入れて区別する必要あり
    # 理由としては、デフォルトで何かしらで画像が入っていないと、特にサブの場合変わったviewになる
    @prototype.prototype_images.build
  end

  def show
  end

  private
    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

end
