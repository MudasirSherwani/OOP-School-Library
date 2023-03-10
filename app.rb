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

end
