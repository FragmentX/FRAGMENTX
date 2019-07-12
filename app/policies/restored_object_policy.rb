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
    @user
  end

  def new?
    create?
  end

  def update?
    @user && @user.id == @object.user_id
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
