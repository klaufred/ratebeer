module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    return 0 if ratings.empty?
    ratings.map(&:score).inject(&:+)/ratings.count.to_f
  end
end