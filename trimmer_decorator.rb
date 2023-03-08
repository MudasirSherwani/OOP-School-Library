require_relative 'name_decorator'
require_relative 'person'
require_relative 'capitalize_decorator'

class TrimmerDecorator < NameDecorator
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    name = @nameable.correct_name
    name.length > 10 ? name[0...10] : name
  end
end
