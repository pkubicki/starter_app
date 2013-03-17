require 'spec_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of(:email) }
    
    it "should require proper format of email" do
      user = build(:user, email: 'invalid_email')
      user.valid?
      expect(user).to have(1).error_on(:email)
    end        

    it { create(:user); should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:login) } 
    it { create(:user); should validate_uniqueness_of(:login).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should ensure_length_of(:password).is_at_least(8) } 
    it { should validate_confirmation_of(:password) } 

    it "doesn't validate password on update if not given" do
      user = create(:user)
      user.password = nil
      user.valid?
      expect(user).to have(:no).errors_on(:password)
    end
    
    it "should require password to have uppercase letters" do
      user = build(:user, password: "secret123")
      user.valid?
      expect(user).to have(1).error_on(:password)
    end
   
    it "should require password to have dights" do
      user = build(:user, password: "SecretXXX")
      user.valid?
      expect(user).to have(1).error_on(:password)
    end 
  end
end
