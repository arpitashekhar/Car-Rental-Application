
require 'test_helper'



class CarTest < ActiveSupport::TestCase
test "should not be able to suggest car without name" do
car = Car.new
car.name = ""
car.model = "BMW"
car.license = "7777777"
car.manufacturer= "BMW"
car.hourly= "15"
car.style= "Coupe"
car.location= "Malibu"
assert_not   car.save
end

test "should not save car without valid model name" do
car = Car.new
car.name = "BMW"
car.model = ""
car.license = "7777777"
car.manufacturer= "BMW"
car.hourly= "15"
car.style= "Coupe"
car.location= "Malibu"
assert_not   car.save
end

test "should not save car which does not have license as less than or more than 7 charecters" do
car = Car.new
car.name = "BMW"
car.model = "BMW"
car.license = ""
car.manufacturer= "BMW"
car.hourly= "15"
car.style= "Coupe"
car.location= "Malibu"
assert_not   car.save
end
test "should not save car without valid manufacturer" do
car = Car.new
car.name = ""
car.model = "BMW"
car.license = "7777777"
car.manufacturer= "BMW"
car.hourly= "15"
car.style= "Coupe"
car.location= "Malibu"
  assert_not   car.save
  end
test "should not save car without valid hourly rates" do
    car = Car.new
    car.name = ""
    car.model = "BMW"
car.license = "7777777"
        car.manufacturer= "BMW"
    car.hourly= "15"
      car.style= "Coupe"
        car.location= "Malibu"
  assert_not   car.save
  end
  test "should have one of the three styles" do
    car = Car.new
    car.name = ""
    car.model = "BMW"
    car.license = "7777777"
    car.manufacturer= "BMW"
  car.hourly= "15"
      car.style= ""
          car.location= "Malibu"
  assert_not   car.save
  end
  test "should not save car without valid location" do
    car = Car.new
    car.name = ""
    car.model = "BMW"
    car.license = "7777777"
    car.manufacturer= "BMW"
  car.hourly= "15"
      car.style= ""
          car.location= ""
  assert_not   car.save
  end

end
