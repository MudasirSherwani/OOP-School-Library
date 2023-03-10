require_relative 'book'
require_relative 'classroom'
require_relative 'rental'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require 'date'

class App
  attr_accessor :books, :rentals, :people

  def initialize
    @books = []
    @people = []
  end

  def list_books
    book_data = ''
    @books.each do |book|
      book.instance_variables.each do |val|
        value = book.instance_variable_get(val)
        val = val.to_s.delete('@')
        val = val.capitalize
        book_data += " #{val}: #{value}" unless val.include?('Rentals')
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
    teacher = Teacher.new(ag, nm, specialization)
    @people.push(teacher)
    puts 'Teacher added successfully'
  end
  

end
