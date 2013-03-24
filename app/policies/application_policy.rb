class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    YamledAcl.permission?(:show) && scope.where(:id => record.id).exists?
  end

  def create?
    YamledAcl.permission?(:create)
  end

  def new?
    create?
  end

  def update?
    YamledAcl.permission?(:update) && scope.where(:id => record.id).exists? 
  end

  def edit?
    update?
  end

  def destroy?
    YamledAcl.permission?(:destroy) && scope.where(:id => record.id).exists? 
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end 
end

