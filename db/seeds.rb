# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

puts 'Cleaning database....'
Movie.destroy_all

3.times do |i|
  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{i + 1}"
  user_serialized = URI.open(url).read
  details = JSON.parse(user_serialized)['results']
  base_url = 'https://image.tmdb.org/t/p/original'

  # p details['results'][0]['title']
  # p details['results'][0]['overview']
  # p details['results'][0]['vote_average']
  # p details['results'][0]['poster_path']

  details.each do |detail|
    movie = Movie.new(
      title: detail['title'],
      overview: detail['overview'],
      poster_url: "#{base_url}#{detail['poster_path']}",
      rating: detail['vote_average']
    )
    movie.save

    puts "Movie #{movie.id} created!"
  end
end
