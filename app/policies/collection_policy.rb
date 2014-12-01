  class CollectionPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @collection = model
  end

  def index?
    false
  end

  def show?
    true
  end

  def edit?
    @current_user.admin? or @current_user == @collection.user
  end

  def update?
    # true
    @current_user.admin? or @current_user == @collection.user
  end

  def destroy?
    return false if @current_user == @collection.user
    @current_user.admin?
  end

end
