class UserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def update?
    super && record.id % 2 == 1
  end

  def destroy?
    super && record.id % 2 == 1
  end
end
