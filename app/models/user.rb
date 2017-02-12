class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password

  PASSWORD_FORMAT = /\A
  (?=.{4,})
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
/x

  validates :password, length: { minimum: 4 }
  validates :password, format: {with: PASSWORD_FORMAT}

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30
                       }

  has_many :ratings , dependent: :destroy
  has_many :memberships , dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style

  end

end
