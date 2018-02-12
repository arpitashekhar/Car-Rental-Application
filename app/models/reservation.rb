class Reservation < ApplicationRecord

  validates :startdate, date:true
  validates :enddate, date:true
  validates :enddate,
            date: { after: :startdate }
  validates :enddate,
            date: {before: Time.now + 7.days}

  validates :carid, :presence => true
  validates :userid, :presence => true
  validates :reservation_cost, :presence => true

  def validateReservationDuration
    if (((enddate-startdate)/1.hour).round > 10 || ((enddate-startdate)/1.hour).round < 1)
      #errors.add(:enddate, "Duration of reservation can be upto 10 hours")
      return true
    end
  end
  def getReservationDuration
    duration = ((enddate-startdate)/1.hour).round
      return duration
  end

  validates :reservation_cost, :presence => true
  validates :status, :inclusion => { :in => ["Cancelled", "CheckedOut","Reserved","Returned"] }, :presence => true
end
