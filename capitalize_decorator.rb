require_relative 'name_decorator'

class CapitalizeDecorator < NameDecorator
  def correct_name
    @nameable.correct_name.upcase
  end
end
