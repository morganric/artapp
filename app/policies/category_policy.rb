  class PiecePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @category = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    @current_user.admin?
  end

  def edit?
    @current_user.admin?

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end

end
