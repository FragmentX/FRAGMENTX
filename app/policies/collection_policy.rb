class CollectionPolicy
  attr_reader :user, :collection

  def initialize(user, collection)
    @user = user
    @collection = collection
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
    @user && @user == @collection.user
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
