require 'rails_helper'

describe Comment  do
  let(:post_comment) { build(:comment, :post_comment) }

  context "validations" do
    it "is valid with default attributes" do
      expect(post_comment).to be_valid
    end

    it "saves default attributes" do
      expect { post_comment.save! }.to_not raise_error
    end

    it "without body is invalid" do
      expect(build(:comment, :post_comment, body: nil)).to_not be_valid
    end
  end


  describe "polymorphic commenting associations" do

    let( :post_comment ) { create( :comment, :post_comment ) }
    let( :photo_comment ) { create( :comment, :photo_comment ) }

    it {is_expected.to belong_to(:commentable)}
    specify "comments respond to their parent association" do
      expect( post_comment ).to respond_to( :commentable )
    end

    specify "parents respond to their child associations" do
      expect( post_comment.commentable ).to respond_to( :comments )
    end


  end
end