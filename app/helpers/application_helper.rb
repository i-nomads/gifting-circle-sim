module ApplicationHelper
  def number_to_currency(amount, options = {})
    super(amount, precision: 0)
  end
end
