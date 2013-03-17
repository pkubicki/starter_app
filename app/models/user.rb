class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :login,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    email: true
  validates :password,
    presence: { on: :create },
    length: { minimum: 8, if: :password },
    confirmation: { if: :password }
  validate :password_strength, if: :password

  private

  def password_strength
    if !(password =~ /^.*(?=.{6,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).*$/)
      errors.add(:password, :too_weak)
    end
  end

end
