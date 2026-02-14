# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Category.find_or_create_by!(name: "Food")
Category.find_or_create_by!(name: "Transport")
Category.find_or_create_by!(name: "Entertainment")
Category.find_or_create_by!(name: "Shopping")
Category.find_or_create_by!(name: "Health")
Category.find_or_create_by!(name: "Education")
Category.find_or_create_by!(name: "Other")
Category.find_or_create_by!(name: "Miscellaneous")
Category.find_or_create_by!(name: "Rash")
