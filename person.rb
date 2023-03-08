require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission = 'true')
    super()
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def isof_age?
    @age.to_i >= 18
  end

  def can_use_services?
    isof_age? || @parent_permission
  end

  def correct_name
    @name
  end
end
