require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }
  let(:post_object) { create(:post) }
  context "logged in" do

    before do
      cookies[:auth_token] = user.auth_token
    end

    describe "GET #index" do
      it "sets the instance vars correctly" do
        get :index, params: { user_id: user.id }
        expect(assigns(:user)).to eq(user)
        expect(assigns(:profile)).to eq(user.profile)
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:comment)).to be_a(Comment)
      end

      it "renders the timeline page" do
        get :index, params: { user_id: user.id }
        expect(response).to render_template :index
      end
    end


    describe "POST #create" do

      it "sets instance variables correctly" do
        post :create, params: { user_id: user.id, post: attributes_for(:post) }

        expect(assigns(:post)).to be_a Post
        expect(assigns(:post).user_id).to eq(user.id)
      end

      it "redirects to last page if saved correctly" do
        post :create, params: { user_id: user.id, post: attributes_for(:post) }
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to(session[:referer])
      end

      it "redirects to last page if not saved correctly" do  post :create, params: { user_id: user.id, post: attributes_for(:post, body: nil) }
        expect(flash[:error]).to_not eq(nil)
        expect(response).to redirect_to(session[:referer])
      end
    end


  end
end
