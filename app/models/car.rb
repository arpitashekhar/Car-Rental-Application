class Car < ApplicationRecord

  validates :name, :presence => true
  validates :model ,format: { with: /\A[0-9a-zA-Z]+\z/}, :presence =>true
  validates :license, length: { is: 7 } , uniqueness: true, :presence =>true
  validates :manufacturer, :presence =>true
  validates :hourly_rate, :presence =>true, numericality: {only_float: true}
  validates :style, :inclusion => { :in => ["Coupe", "Sedan","SUV"] }, :presence =>true
  validates :location, :presence =>true
  validates :carstatus, :inclusion => { :in => ["Available", "CheckedOut","Reserved"] }, :presence =>true
  validates :active, :inclusion => { :in => ["Active","Inactive"]} , :presence =>true
  def self.search(search)
    if search
      where("location LIKE ?", "%#{search}%")
    else
      self.all
    end
  end
end
#Need to add a field suggested by- that car is suggested by admin or
#customerupdated_at12