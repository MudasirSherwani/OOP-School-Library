require_relative 'book'
require_relative 'classroom'
require_relative 'rental'
require_relative 'person'
require_relative 'student'
require 'date'

classroom = Classroom.new('Data Science')
student1 = Student.new('Mudasir Sherwani')
student2 = Student.new('Ashraf')
classroom.add_student(student1)
classroom.add_student(student2)

# Create some books and rentals
book1 = Book.new('The Great Book', 'Fitzgerald')
book2 = Book.new('To Kill a Tiger', 'Harper')
book3 = Book.new('1895', 'George Orwell')
person1 = Person.new(32, 'Alice')
person2 = Person.new(25, 'Bob')
Rental.new('2022-02-02', book1, person1)
Rental.new(Date.today, book2, person1)
Rental.new(Date.today, book3, person2)

# Check rented books for a person
puts person1.rented_books.map(&:title)  