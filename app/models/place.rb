class Place < OpenStruct

  def self.rendered_fields
    [:id, :name, :status, :street, :city, :country]
  end
end