class Prototypes::TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @prototypes = Prototype.tagged_with(@tag).eager_load(:user, :prototype_images)
  end
end

# 確認3 eager_loadとincludeがなかなか使いこなせない。大きな違いは他のテーブルとの結合を必ずしたいかそうではないかなのですか？
# 結果的に少ない方が良さそうなので両方試してsplの発行回数、合計時間を比べます。
# 検証結果 eager_load (1.3 ms), includes (1.7 ms) よって、今回はeager_loadを使用