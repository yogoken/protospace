include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :prototype_image do
    content { fixture_file_upload("spec/fixtures/img/test.png", "content/png") }
    trait :main do
      role :main
    end

    trait :sub do
      role :sub
    end
  end
end
