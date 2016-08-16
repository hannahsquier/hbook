require 'rails_helper'

describe User  do
  let (:user) { build(:user) }

  context "validations" do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves default attributes" do
      expect { user.save! }.to_not raise_error
    end

    it { is_expected.to have_secure_password }


    it "without first name is invalid" do
      expect(build(:user, first_name: nil)).to_not be_valid
    end
    it "without last name is invalid" do
      expect(build(:user, last_name: nil)).to_not be_valid
    end

    it "without email is invalid" do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it "with duplicate email is invalid" do
      user.save!
      expect(build(:user, email: user.email)).to_not be_valid
    end

    it "without valid email format is invalid" do
      expect(build(:user, email: "asdf@asd")).to_not be_valid
    end

    it "without birthday within past 125 years is invalid" do
      expect(build :user, birthday: Time.now - 126.years).to_not be_valid
      expect(build :user, birthday: Time.now + 1.years).to_not be_valid
    end

    it "without gender is valid" do
      expect(build(:user, gender: nil)).to be_valid
    end

    it "with invalid gender is invalid" do
      expect(build(:user, gender: "potatoes")).to_not be_valid
    end

    it { validate_length_of(:password).is_at_least(6).is_at_most(20) }
  end

  context "associations" do
    context "post associations" do
      let(:post) { build(:post) }
      it "responds to posts"  do
        expect(user).to respond_to(:posts)
      end

      specify "linking a valid author succeeds" do
        post.author = user
        post.receiver = user
        expect(post).to be_valid
      end
    end

    context "comment associations" do
      let(:post_comment) { build(:comment, :post_comment) }

      it "responds to comments"  do
        expect(user).to respond_to(:comments)
      end

      specify "linking a valid comment succeeds" do
        post_comment.author = user
        expect(post_comment).to be_an_instance_of(Comment)
        expect(post_comment.author).to_not be(nil)

      end
    end

    context "profile associations" do

      it "responds to profile"  do
        expect(user).to respond_to(:profile)
      end

      specify "creating a user also creates an empty profile" do
        user = create(:user)
        expect(user.profile).to be_valid
      end

    end

    context "like associations" do
      let(:comment_like) { build(:like, :comment_like) }
      let(:post_like) { build(:like, :post_like) }

      it "responds to likes"  do
        expect(user).to respond_to(:likes)
      end

      specify "linking a valid like succeeds" do
        comment_like.liker = user
        post_like.liker = user
        expect(comment_like).to be_an_instance_of(Like)
        expect(comment_like.liker).to_not be(nil)
        expect(post_like).to be_an_instance_of(Like)
        expect(post_like.liker).to_not be(nil)
      end
    end

  end

  context "methods" do
    describe "#full_name" do
      it "returns full name as string" do
        expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
      end
    end

    describe "#generate_auth_token" do
      it "generates an auth token after user is created" do

        expect(user.auth_token).to be_a(String)

      end
    end

    describe "#regenerate_auth_token" do
      it "regenerates an auth token when called" do
        original_auth_token = user.auth_token
        user.regenerate_auth_token
        expect(user.auth_token).to_not eq(original_auth_token)
      end
    end
  end



end