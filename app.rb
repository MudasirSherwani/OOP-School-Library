require_relative 'book'
require_relative 'classroom'
require_relative 'rental'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'file_storage'
require'json'
require 'date'
require 'pry'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @peoples = []
    @rentals = []
    @stored_people = Storage.new('store/people.json')
    @stored_books = Storage.new('store/books.json')
    @stored_rentals = Storage.new('store/rentals.json')
  end

  def list_books
    loaded_books = ''
    if @stored_books.valid? == true
      loaded_books = @stored_books.load
      loaded_books.each_with_index do |book, i|
        puts "Book_No: [#{i + 1}] Book ID: #{i}   Title: #{book['title']}   Author: #{book['author']}\n"
      end
    else
      puts 'Books Not Found !!'
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
    loaded_books = @stored_books.load
      @books.each do |book|
      loaded_books << {
        title: book.title, author: book.author
      }
    end
    @stored_books.save(loaded_books)
  end

  def list_people
    loaded_people = ''
    if @stored_people.valid? == true
      loaded_people = @stored_people.load
      loaded_people.each_with_index do |people, i|
        puts "Person_No: [#{i + 1}] Person ID: #{people['id']}   Age: #{people['age']} Name: #{people['name']}}\n"
      end
    else
      puts 'Person Not Found !!'
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
    @peoples.push(student)
    puts 'Student added  successfully'
    loaded_person = @stored_people.load
      @peoples.each do |person|
        loaded_person << {
        age: person.age, name: person.name, id: person.id
      }
    end
    @stored_people.save(loaded_person)

  end

  def create_teacher
    puts 'Age: '
    ag = gets.chomp
    puts 'Name: '
    nm = gets.chomp
    puts 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(ag, nm, true, specialization)
    @peoples.push(teacher)
    puts 'Teacher added successfully'
    loaded_person = @stored_people.load
      @peoples.each do |person|
        loaded_person << {
        age: person.age, name: person.name, id: person.id, specialization: person.specialization
      }
    end
    @stored_people.save(loaded_person)
  end

  def create_rental
    puts 'Select a book from the list by No'
    list_books
    selected_book = gets.chomp.to_i
    puts 'Select a person from the list by No'
    list_people
    selected_person = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    book_geter = @stored_people.load.select { |p| p['id'] == selected_person }
    @rentals.push(Rental.new(date, @stored_books.load[selected_book], book_geter[0]))
    loaded_rentle = @stored_rentals.load
    @rentals.each do |rental|
      loaded_rentle << { date: rental.date, book: { title: rental.book['title'], author: rental.book['author'] },
                        person: { id: rental.person['id'], name: rental.person['name'], age: rental.person['age'],
                                  class: rental.person['class'] } }
    end
    puts 'Rental created successfully'
    @stored_rentals.save(loaded_rentle)


  end

  def list_rentals
    loaded_rental = @stored_rentals.load
    list_people
    print 'Id of person: '
    id = gets.chomp.to_i
    person = list_people.select { |p| p['id'] == id }
    return unless person[0]
    puts "#{person[0]['name']}'s rented books: \n"
    loaded_rental.each_with_index do |rental, _i| \
      if rental['person']['id'] == id
        puts "Date: #{rental['date']}, Book: #{rental['book']['title']} by #{rental['book']['author']}"
      end
    end
  end

end
