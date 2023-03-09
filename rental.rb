class Rental
  attr_accessor :date, :person, :book

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    book.add_rentals(self)
    person.add_rentals(self)
  end
end
