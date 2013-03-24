require 'spec_helper'

describe ApplicationHelper do
  include Capybara::DSL

  describe "#flash_messages" do
    before do
      flash[:notice] = "Lorem ipsum"
    end

    subject { Capybara.string(helper.flash_messages)}

    it { should have_css('div.alert.alert-success') }
    it { should have_content('Lorem ipsum') }
  end

  describe "#alert_class" do
    context "when :alert given" do
      it { expect(helper.alert_class(:alert)).to eq("alert-error") }
    end
    
    context "when :notice given" do
      it { expect(helper.alert_class(:notice)).to eq("alert-success") }
    end
 
    context "when :other_value given" do
      it { expect(helper.alert_class(:other_value)).to eq("alert-other_value") }
    end 
  end

  describe "#form_errors_on_base" do
    let(:object) { double(:object, errors: {base: ['Lorem ipsum']}) }
    subject { Capybara.string(helper.form_errors_on_base(object)) }

    it { should have_selector('div.alert.alert-block.alert-error ul li') } 
    it { should have_content('Lorem ipsum') }
  end
  
  describe "#control_group" do
    let(:object) { double(:object, errors: {title: ['required']}) }
    subject { Capybara.string(helper.control_group(object, :title) {}) }

    it { should have_selector('div.control-group.error') } 
  end 

  describe "#currency" do
    it { expect(helper.currency(1_000.25)).to eq('1 000,25') }
  end
end
