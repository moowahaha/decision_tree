class Car
  attr_accessor :make, :model, :transmission, :price

  def initialize params
    params.each do |attribute, value|
      send(attribute.to_s + '=', value)
    end
  end
end