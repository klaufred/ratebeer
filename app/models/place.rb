class Place < OpenStruct

  def self.rendered_fields
    [:id, :name, :status, :street, :city, :country]
  end

  def address_line
    ERB::Util.url_encode("#{street} #{city} #{country}")
  end

  def url
    "//www.google.com/maps/embed/v1/place?q=#{address_line}&zoom=10&key=#{ENV['GOOGLEKEY']}"
  end
end