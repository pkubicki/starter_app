require 'spec_helper'

describe ApplicationHelper do

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

  describe "#link_to_with_icon" do
    subject do 
      Capybara.string(
	helper.link_to_with_icon(
	  'Lorem ipsum', 
	  'icon-name', 
	  'url',
	  { class: 'class-name' }
	)
      )
    end

    it { should have_selector('a.class-name i.icon-name') }     
    it { should have_content('Lorem ipsum') }     
  end

  describe "#button_with_icon" do
    subject do 
      Capybara.string(
	helper.button_with_icon(
	  'Lorem ipsum', 
	  'icon-name', 
	  { class: 'class-name' }
	)
      )
    end

    it { should have_selector('button.class-name i.icon-name') }     
    it { should have_content('Lorem ipsum') }     
  end
 
  describe "#nav_link_to" do
    context "when not allowed to" do
      subject do 
        helper.nav_link_to(
          'Lorem ipsum', 
          '/', 
          { class: 'class-name' }
        )
      end 
      before { helper.stub(:allowed_to?) { false } }
      it { should be_nil }     
    end
    
    context "when allowed to" do
      subject do 
        Capybara.string(
          helper.nav_link_to(
            'Lorem ipsum', 
            '/', 
            { class: 'class-name' }
          )
        )
      end
      before { helper.stub(:allowed_to?) { true } }
      it { should have_selector('li a.class-name') }     
      it { should have_content('Lorem ipsum') }     
    end 
  end
 
  describe "#nav_link_to_with_icon" do
    context "when not allowed to" do
      subject do 
        helper.nav_link_to_with_icon(
          'Lorem ipsum',
	  'icon-name', 
          '/', 
          { class: 'class-name' }
        )
      end 
      before { helper.stub(:allowed_to?) { false } }
      it { should be_nil }     
    end
    
    context "when allowed to" do
      subject do 
        Capybara.string(
          helper.nav_link_to_with_icon(
            'Lorem ipsum', 
	    'icon-name', 
            '/', 
            { class: 'class-name' }
          )
        )
      end
      before { helper.stub(:allowed_to?) { true } }
      it { should have_selector('li a.class-name i.icon-name') }     
      it { should have_content('Lorem ipsum') }     
    end 
  end
 
  describe "#nav_dropdown" do
    subject { Capybara.string(helper.nav_dropdown('Lorem ipsum') {}) }

    it { should have_selector('li.dropdown a.dropdown-toggle b.caret') } 
    it { should have_selector('li.dropdown ul.dropdown-menu') } 
  end 
 
  describe "#ldt" do
    context "when nil given" do
      it { expect(helper.ldt(nil)).to be_nil }
    end

    context "when nil given" do
      it { expect(helper.ldt("2013-01-01 12:00:00".to_datetime)).to eq("2013-01-01 12:00:00") }
    end
  end

  describe "#ldt" do
    context "when 'q' params contain datetime value" do
      before { helper.stub(:params).and_return({ q: { begin_at: "2013-01-01 12:00:00".to_datetime } }) }
      it { expect(helper.ldtqp(:begin_at)).to eq("2013-01-01 12:00:00") }
    end

    context "when 'q' params don't exist" do
      before { helper.stub(:params).and_return({}) }
      it { expect(helper.ldtqp(:begin_at)).to be_nil }
    end 
  end   
end
