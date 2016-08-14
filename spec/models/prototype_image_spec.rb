require 'rails_helper'

describe PrototypeImage do
  describe 'association' do
    it 'is associated with a prototype' do
      prototype = create(:prototype)
      prototype_image = create(:prototype_image, :main, prototype: prototype)
      expect(prototype_image.prototype).to eq prototype
    end
  end

  describe '#create' do
    it 'has the wrong content format' do
      content = build(:prototype_image, :main, content: fixture_file_upload("img/test.bmp", 'content/bmp'))
      content.valid?
      expect(content.errors[:content][0]).to include("You are not allowed to upload")
    end

    describe "with valid attributes" do
      it 'has a valid factory' do
        prototype_image = build(:prototype_image, :main)
        expect(prototype_image).to be_valid
      end
    end

    describe 'without a content attribute' do
      it 'returns error'
    end

    describe 'without a role attribute' do
      it 'returns error'
    end
  end
end
