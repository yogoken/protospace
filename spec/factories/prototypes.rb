FactoryGirl.define do
  factory :prototype do
    title { Faker::Name.name }
    catch_copy { Faker::Lorem.word }
    concept { Faker::Lorem.sentence }
    user

    # traitを使うことで属性定義をわかりやすくでき、グループ化することも可能になる
    trait :with_likes do
      # ignoreとtransientはほぼ同じで、DBの属性とは関係ない属性を定義する
      transient do
        likes_count 5
      end

      # prototype = 作成されたprototypeインスタンス自身
      # evaluator = transientないの属性を含むファクトリのすべての属性を保持
      # create_listの第2引数は、作成する関連を持ったレコードの数を指定する
      after(:create) do |prototype, evaluator|
        prototype.likes << create_list(:like, evaluator.likes_count)
      end
    end
    # 使い方
    # create(:prototype).likes.length => 0
    # create(:prototype, :with_likes).likes.length => 5
    # create(:prototype, :with_likes, likes_count: 15).likes.length => 15

    trait :with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |prototype, evaluator|
        prototype.comments << create_list(:comment, evaluator.comments_count)
      end
    end
  end
end
