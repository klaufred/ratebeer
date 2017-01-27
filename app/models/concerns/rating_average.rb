module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    combinedScore = ratings.average(:score)

    "Has #{ratings.count} #{'rating'.pluralize(ratings.count)}, average #{combinedScore}"
  end
end