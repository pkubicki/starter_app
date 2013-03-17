require 'spec_helper'

describe ApplicationHelper do
  describe "#flash_messages" do
    before do
      flash[:notice] = "Lorem ipsum"
    end

    it { expect(helper.flash_messages).to match(/Lorem ipsum/) }

    it("has alert-success class") do 
      expect(helper.flash_messages).to match(/alert-success/)
    end
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
    
    it { expect(helper.form_errors_on_base(object)).to match(/Lorem ipsum/) }
  end
  
  describe "#control_group" do
    let(:object) { double(:object, errors: {title: ['Lorem ipsum']}) }
    
    it('has error class') do 
      expect(helper.control_group(object, :title) {}).to match(/error/) 
    end
  end 

  describe "#currency" do
    it { expect(helper.currency(1_000.25)).to eq('1 000,25') }
  end
end
