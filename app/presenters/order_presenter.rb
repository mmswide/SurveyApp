class OrderPresenter
  def initialize(order, template)
    @order = order
    @template = template
  end

  def h
    @template
  end
end