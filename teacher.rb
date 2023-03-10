require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, name = 'Unknown', parent_permission = 'true', specialization = 'no-subject')
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
