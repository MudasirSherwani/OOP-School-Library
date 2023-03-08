require_relative 'name_decorator'

class CapitalizeDecorator < NameDecorator
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name.capitalize
  end
end
