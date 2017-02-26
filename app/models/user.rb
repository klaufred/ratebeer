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
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count.to_f||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

  def change_block
    return nil if not current_user.admin?
    user = User.find(params[:id])
    if user.blocked?
      user.update_attribute :blocked, false
      redirect_to :back, notice:"account restored"
    else
      user.update_attribute :blocked, true
      redirect_to :back, notice:"account frozen"
    end
  end

end
