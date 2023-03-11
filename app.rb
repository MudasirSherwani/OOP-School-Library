require 'pry'
require_relative 'book'
require_relative 'classroom'
require_relative 'rental'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require 'date'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    book_data = ''
    @books.each do |book|
      book.instance_variables.each do |val|
        value = book.instance_variable_get(val)
        val = val.to_s.delete('@')
        val = val.capitalize
        book_data += " #{val}: #{value}" unless val.include?('Rentals')
        # binding.pry
      end
      book_data += "\n"
    end
    if book_data == ''
      puts 'Books Not Found !!'
    else
      puts book_data
    end
  end

  def create_book
    puts 'Title: '
    t = gets.chomp
    puts 'Author: '
    a = gets.chomp
    book = Book.new(t, a)
    @books.push(book)
    puts 'Book created successfully'
  end

  def list_people
    person_data = ''
    @people.each do |p|
      p.instance_variables.each do |val|
        value = p.instance_variable_get(val)
        val = val.to_s.delete('@')
        val = val.capitalize
        person_data += " #{val}: #{value} " unless val.include?('Rentals') or val.include?('Classroom')
      end
      person_data += "\n"
    end
    if person_data == ''
      puts 'No person Found !!'
    else
      puts person_data
    end
  end

  def create_person
    puts 'Choose an option student(1) or teacher(2)?'
    choise = gets.chomp.to_i
    return unless choise != 0

    case choise
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid Input ( Enter 0 for Exit)'
      create_person
    end
  end

  def create_student
    puts 'Age: '
    ag = gets.chomp
    puts 'Name: '
    nm = gets.chomp
    puts 'Has parent permission? [Y/N]'
    parent_permission = gets.chomp.upcase == 'Y'
    student = Student.new(ag, nm, parent_permission)
    @people.push(student)
    puts 'Student added  successfully'
  end

  def create_teacher
    puts 'Age: '
    ag = gets.chomp
    puts 'Name: '
    nm = gets.chomp
    puts 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(ag, nm, true, specialization)
    @people.push(teacher)
    puts 'Teacher added successfully'
  end

  def create_rental
    puts 'Select a book from the list by No'
    books_index
    selected_book = gets.chomp.to_i
    puts 'Select a person from the list by No'
    people_index
    selected_person = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    book = @books[selected_book]
    person = @people[selected_person]
    rental = Rental.new(date, book, person)
    @rentals.push(rental)
    puts 'Rental created successfully'
  end

  def list_rentals
    rental_data = ''
    print 'To see person rentals enter the person ID: '
    @id = gets.chomp.to_i
    rental_data = 'Rented Books: '
    @rentals.each do |rent|
      person = rent.instance_variable_get(:@person)
      person_id = person.instance_variable_get(:@id)
      next unless person_id == @id

      book = rent.instance_variable_get(:@book)
      title = book.instance_variable_get(:@title)
      author = book.instance_variable_get(:@author)
      rental_data += " Date: #{rent.date} Book: #{title} by Author: #{author} "
      rental_data += "\n"
    end
    if rental_data == 'Rented Books: '
      puts 'No Rental Data Found !!'
    else
      puts rental_data
    end
  end

  def books_index
    @books.each_with_index do |book, index|
      book_data = " #{index}: "
      book.instance_variables.each do |val|
        value = book.instance_variable_get(val)
        val = val.to_s.delete('@')
        book_data += " #{val}: #{value} " unless val.include?('rentals') or val.include?('classroom')
      end
      puts book_data
    end
  end

  def people_index
    @people.each_with_index do |person, index|
      person_data = " #{index}: "
      person.instance_variables.each do |val|
        value = person.instance_variable_get(val)
        val = val.to_s.delete('@')
        person_data += " #{val}: #{value} " unless val.include?('rentals') or val.include?('classroom')
      end
      puts person_data
    end
  end
end
