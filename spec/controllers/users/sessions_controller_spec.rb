require 'spec_helper'

describe Users::SessionsController do
  describe "#new" do
    it "rendres the 'new' template" do 
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "when user exists" do
      it "redirects to root_path" do 
        subject.stub(:login) { build_stubbed(:user, login: 'joe.doe') }
        post :create, { login: 'joe.doe', password: 'Secret123' }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user doesn't exist" do
      it "renders 'new' template" do 
        subject.stub(:login) { nil }
        post :create, { login: 'joe.doe', password: 'Secret123' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    it "redirects to root_path" do
      subject.stub(:current_user) { build_stubbed(:user) }
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
  
end
