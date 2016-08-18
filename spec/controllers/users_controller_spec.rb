require 'rails_helper'
require 'pry'
describe UsersController do
  let(:user) { create(:user) }

  context "Not Signed in" do
    before do
      cookies[:auth_token] = nil
    end

    describe 'POST #create' do
      it "allows you to create user with valid attributes" do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "flashes success message and redirects to current timeline if you create user with valid attributes" do
         post :create, params: { user: attributes_for(:user) }

         expect(response).to redirect_to(user_posts_path(assigns(:user)))
         expect(flash[:success]).to_not eq(nil)
      end

      it "doesn't allow you to create user with invalid attributes" do
        expect {
          post :create, params: { user: attributes_for(:user, first_name: nil) }
        }.to_not change(User, :count)
      end

      it "flashes sorry message and renders new user template" do
         post :create, params: { user: attributes_for(:user, first_name: nil)}

         expect(response).to render_template :new
         expect(flash[:sorry]).to_not eq(nil)
      end

      # it "creates a profile after it creates a user" do
      #   profile_count = Profile.count
      #   post :create, params: { user: attributes_for(:user, first_name: nil) }
      #   profile_count_after = Profile.count
      #   expect(profile_count - profile_count_after).to eq(1)
      # end
    end

     describe 'GET #new' do
      it "renders new page when not logged in" do
        get :new
        expect(response).to render_template :new
      end

       it "correctly sets instance vars" do
        get :new
        expect(assigns(:user)).to be_an_instance_of(User)
      end
    end

    describe "GET #show" do
      it "redirects to root path when not signed in" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET #index" do
      it "redirects to root path when not signed in" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

     describe "GET #edit" do
      it "redirects to root path when not signed in" do
        get :edit, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT #update" do
      it "redirects to root path when not signed in" do
        put :update, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  ######## Signed in

  context "Signed in" do
    before do
      cookies[:auth_token] = user.auth_token
    end

    describe 'GET #index' do

      let(:user2) { create(:user) }

      it "correctly sets instance var @users" do
        get :index
        users = [user, user2]
        expect(assigns(:users)).to eq(users)

      end
      it "renders users index page" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do
      it "redirects to current timeline when signed in" do
        get :new
        expect(response).to redirect_to user_posts_path(user.id)
      end
    end

    describe 'POST #create' do
      it "redirects to current timeline when signed in" do
        user
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to user_posts_path(user.id)
      end
    end

    describe 'GET #show' do
      it "correctly sets instance var" do
        get :show, params: { id: user.id}
        expect(assigns(:profile)).to eq(user.profile)
      end

      it "renders the show page" do
        get :show, params: { id: user.id}
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      it "correctly sets instance var @user and @profile" do
        get :edit, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
        expect(assigns(:profile)).to be_a(Profile)
      end

      it "renders edit page" do
        get :edit, params: { id: user.id}
        expect(response).to render_template :edit
      end

    end

    describe 'PUT #update' do

      it "correctly sets instance var @user" do

        put :update, params: { id: user.id, user: attributes_for(:user, email: "other_email@gmail.com") }
        user.reload
        expect(assigns(:user).email).to eq( "other_email@gmail.com")
      end

      it "redirects to about page if saved correctly and renders success flash" do
        put :update, params: { id: user.id, user: attributes_for(:user, email: "other_email@gmail.com") }
        expect(flash[:success]).to_not eq(nil)
        expect(response).to redirect_to user_path(user.id)
      end


      it "redirects to edit page if saved incorrectly and renders sorry flash" do
        put :update, params: { id: user.id, user: attributes_for(:user, birthday: Time.now + 5.years) }
        expect(flash[:sorry]).to_not eq(nil)
        expect(response).to render_template :edit
      end

    end

  end

end
