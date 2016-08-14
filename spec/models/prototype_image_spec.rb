require 'rails_helper'

describe PrototypeImage do
  describe 'association' do
    it 'is associated with a prototype' do
      prototype = create(:prototype)
      prototype_image = create(:prototype_image, prototype: prototype)
      expect(prototype_image.prototype).to eq prototype
    end
  end

  describe '#create' do
    it 'has the wrong content format'

    describe "with valid attributes" do
      it 'has a valid factory'
    end

    describe 'without a content attribute' do
      it 'returns error'
    end

    describe 'without a role attribute' do
      it 'returns error'
    end
  end
end
