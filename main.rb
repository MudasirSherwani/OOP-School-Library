require_relative 'app'
require 'pry'

class Main
  newapp = App.new
  loop do
    puts "\n---------------- Main Menu ------------------"
    puts 'Welcome to the School Library App!'
    puts 'Please choose an option:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person id'
    puts '0. Quit'

    choice = gets.chomp

    case choice
    when "1"
      newapp.list_books
    when "2"
      newapp.list_people
    when "3"
      newapp.create_person
    when "4"
      newapp.create_book
    when "5"
      newapp.create_rental
    when "6"
      newapp.list_rentals
    when "0"
      puts 'Thank you for using the School Library App!'
      break
    else
      puts 'Invalid choice. Please choose again.'
    end
  end
end
