class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club
  def to_s
    "Beer Club: #{beer_club.name}"
  end

  def show_member
    "Member: #{user.username}"
  end
end
