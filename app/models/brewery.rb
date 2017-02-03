require 'date'
class Brewery < ActiveRecord::Base
	include RatingAverage
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042,
																		less_than_or_equal_to: 2017,
																		only_integer: true }

	validate :at_most_modern_date

	def at_most_modern_date
		if year.present? && year.date <= Date.today
			errors.add(:year, "can't be in the future")
		end
	end

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2017
		puts "changed year to #{year}"
	end
end
