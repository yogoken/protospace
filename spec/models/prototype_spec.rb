require 'rails_helper'

describe Prototype do
  describe 'associations' do
    it 'is associated with user' do
      user = create(:user)
      prototype = create(:prototype, user: user)
      expect(prototype.user).to eq user
    end

    describe 'with likes' do
      let(:likes_count) { 1 }
      let!(:prototype) { create(:prototype, :with_likes, likes_count: likes_count) }
      # letは遅延評価してくれるが、今回はprototypeを始めにセットしてあげなければcountに1を始めから代入できない
      # よってlet!とビックリマークをつけることで始めに定義されるようになる
      it 'deletes the likes when Prototype is deleted' do
        expect{ prototype.destroy }.to change(Like, :count).by(-1 * likes_count)
      end
    end

    describe 'with comments' do
      it 'deletes the comments when Prototype is deleted'
    end
  end

  describe 'vaildations' do
    describe 'with valid attributes' do
      it 'has valid factory'
    end

    describe 'without valid attributes' do
      it 'is missing a title'
      it 'is missing a catch_copy'
      it 'is missing a concept'
    end
  end

  describe '#liked_by?(user)' do
    describe 'when liked by a user' do
      it 'return true'
    end
    describe 'when not liked by a user' do
      it 'return nil'
    end
  end
end
