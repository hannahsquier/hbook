require 'rails_helper'

describe Post  do
  let (:post) { build(:post) }

  context "validations" do
    it "is valid with default attributes" do
      expect(post).to be_valid
    end

    it "saves default attributes" do
      expect { post.save! }.to_not raise_error
    end

    it "without body is invalid" do
      expect(build(:post, body: nil)).to_not be_valid
    end
  end


  context "associations" do
    context "user associations" do
      let(:author) { build(:user) }
      let (:receiver) {build(:user)}

      it { is_expected.to belong_to :author }

      it "responds to author"  do
        expect(post).to respond_to(:author)
      end

      it "responds to author"  do
        expect(post).to respond_to(:receiver)
      end

    end


    context "comment associations" do
      let(:comment) { build(:comment)}

      it { is_expected.to have_many :comments }

      it "responds to comments"  do
        expect(post).to respond_to(:comments)
      end

      specify "linking a valid post commentable succeeds" do
        comment.commentable = post
        expect(comment).to be_an_instance_of(Comment)
        expect(comment.commentable_type).to eq("Post")
        expect(comment.commentable_id).to eq(post.id)

      end
    end

    context "likes associations" do
      let(:like) { build(:like)}
      it { is_expected.to have_many :likes }
      it "responds to comments"  do
        expect(post).to respond_to(:likes)
      end

      specify "linking a valid like succeeds" do
        like.likeable = post
        expect(like).to be_an_instance_of(Like)
        expect(like.likeable_type).to eq("Post")
        expect(like.likeable_id).to eq(post.id)

      end
    end
  end
end