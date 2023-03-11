require_relative 'nameable'

class Person < Nameable
  attr_accessor :age, :name, :rentals
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission = 'true')
    super()
    @id = Random.rand(1..10_000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
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

  def add_rentals(rent)
    @rentals << rent
  end

  def rented_books
    @rentals.map(&:book)
  end
end
