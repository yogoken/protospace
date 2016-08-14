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
      let(:comments_count) { 1 }
      let!(:prototype) { create(:prototype, :with_comments, comments_count: comments_count) }
      it 'deletes the comments when Prototype is deleted' do
        expect{ prototype.destroy }.to change(Comment, :count).by(-1 * comments_count)
      end
    end
  end

  describe 'vaildations' do
    describe 'with valid attributes' do
      it 'has valid factory' do
        expect(build(:prototype)).to be_valid
      end
    end

    describe 'without valid attributes' do
      it 'is missing a title' do
        prototype = build(:prototype, title: nil)
        prototype.valid?
        expect(prototype.errors[:title]).to include("can't be blank")
      end
      it 'is missing a catch_copy' do
        prototype = build(:prototype, catch_copy: nil)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("can't be blank")
      end
      it 'is missing a concept' do
        prototype = build(:prototype, concept: nil)
        prototype.valid?
        expect(prototype.errors[:concept]).to include("can't be blank")
      end
    end
  end

  describe '#liked_by?(user)' do
    describe 'when liked by a user' do
      it 'return true' do
        user = create(:user)
        prototype = create(:prototype, user: user)
        like = create(:like, prototype: prototype, user: user)
        expect(prototype.liked_by?(user)).to be_truthy
      end
    end
    describe 'when not liked by a user' do
      it 'return nil' do
        user = create(:user)
        another_user = create(:user)
        prototype = create(:prototype, user: another_user)
        like = create(:like, prototype: prototype, user: another_user)
        expect(prototype.liked_by?(user)).to be_falsey
      end
    end
  end
end
