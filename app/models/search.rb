class Search < ApplicationRecord

  def search_cars
    cars = Car.all

    cars = cars.where(["name LIKE ?", name]) if name.present?
    cars = cars.where(["style LIKE ?", style]) if style.present?
    cars = cars.where(["location LIKE ?", location]) if location.present?
    cars = cars.where(["carstatus LIKE ?", carstatus]) if carstatus.present?

    return cars
  end

end
