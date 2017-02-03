class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password

  PASSWORD_FORMAT = /\A
  (?=.{4,})
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
/x

  validates :password, format: {with: PASSWORD_FORMAT}

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30
                       }

  has_many :ratings , dependent: :destroy
  has_many :memberships , dependent: :destroy
  has_many :beers, through: :ratings
end