class RestoredObjectPolicy
  attr_reader :user, :object

  def initialize(user, object)
    @user = user
    @object = object
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user && @user.approved
  end

  def new?
    create?
  end

  def update?
    @user && @user.id == @object.user_id && @user.approved
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
