require 'spec_helper'

describe ApplicationController do
  
  describe "actions authorization" do
    controller do 
      def index
        render text: ''
      end
    end 

    before do
      subject.stub(:authorize_action)
    end

    after { get :index }
    it { subject.should_receive(:authorize_action) }
  end

  describe "policies checks" do
    controller do
      skip_before_filter(:authorize_action)
 
      def index
        render text: ''
      end
  
      def new
        render text: ''
      end
    end

    before do
      subject.stub(:verify_authorized)
    end

    context 'when index action called' do
      after { get :index }
      it { subject.should_not_receive(:verify_authorized) }
    end
 
    context 'when new action called' do
      after { get :new}
      it { subject.should_receive(:verify_authorized) }
    end 
  end

  describe "checking access restrictions" do
    controller do
      skip_before_filter(:authorize_action)

      def index
	raise YamledAcl::AccessDenied
      end
    end
 
    context "when not logged in" do
      it "redirects to root path" do
        subject.stub(:logged_in?) { false }
	get :index
	expect(response).to redirect_to(root_path)
      end
    end
    
    context "when logged in" do
      it "raises access denied error" do
        subject.stub(:logged_in?) { true }
	expect { get(:index) }.to raise_error(YamledAcl::AccessDenied)
      end
    end
  end
end
