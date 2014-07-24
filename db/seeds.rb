# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_names = ["sai_to", "stefan", "garfield", "ash_ketchum", "iron_man"]
user_names.each { |user_name| User.create!(user_name: user_name) }

Poll.create!(title: "Taiwan", author_id: 1)
Poll.create!(title: "Pokemon", author_id: 4)

Question.create!(text: "Is Taiwan a country?", poll_id: 1)
Question.create!(text: "What's a pokemon?", poll_id: 2)
Question.create!(text: "Who is Pikachu?", poll_id: 2)

AnswerChoice.create!(text: "Yes", question_id: 1)
AnswerChoice.create!(text: "No", question_id: 1)
AnswerChoice.create!(text: "An animal", question_id: 2)
AnswerChoice.create!(text: "Your best friend", question_id: 2)
AnswerChoice.create!(text: "Alien", question_id: 3)
AnswerChoice.create!(text: "I don't know", question_id: 3)

Response.create!(responder_id: 1, answer_choice_id: 5)
Response.create!(responder_id: 1, answer_choice_id: 3)
Response.create!(responder_id: 2, answer_choice_id: 2)
Response.create!(responder_id: 3, answer_choice_id: 6)