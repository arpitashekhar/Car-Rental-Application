class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
    @reservations.each do |r|
      if r.status == "Reserved" && r.startdate + 30.minutes < Time.now
        r.update(status: "Cancelled")
        r.save
        @car = Car.find_by(id: r.carId)
        if @car.nil? == false
          @car.update(carstatus: :Available)
          @car.save
        end
      end
      if r.enddate < Time.now && r.status == "CheckedOut"
        r.update(status: "Returned")
        r.save
        @car = Car.find_by(id: r.carId)
        if @car.nil? == false
          @car.update(carstatus: :Available)
          @car.save
        end
      end
    end
    if(current_user.superadmin_role?  || current_user.supervisor_role?)
      @reservations = Reservation.all
    else
      @userId = current_user.id
      @reservations = Reservation.where(userid: @userId)
      @userId = current_user.id
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.userid = current_user.id
    @currentReservationStatus = reservation_params[:status]
    @reservation.status = @currentReservationStatus

    @currentCarId = reservation_params[:carid]
    @reservation.carid = @currentCarId
    @currentUserId = current_user.id

    @currentUserOldReservation=Reservation.find_by(userid: @currentUserId,status:["Reserved","CheckedOut"])

    @currentCar=Car.find_by(id: @currentCarId)
    @hourlyRateReservation=@currentCar.hourly_rate
    @duration=@reservation.getReservationDuration
    @reservation.reservation_cost=@hourlyRateReservation*@duration
   # @reservationsWithinInterval1 = Reservation.where('startdate >= ? AND startdate <= ? AND status = ? AND carid=?', @reservation.startdate, @reservation.enddate,'Reserved', @currentCarId)
    #@reservationsWithinInterval2 = Reservation.where('enddate >= ? AND enddate <= ? AND status = ? AND carid=?', @reservation.startdate, @reservation.enddate,'Reserved', @currentCarId)
    @reservationsWithinInterval1 = Reservation.where('startdate between ? AND ? AND status = ? AND carid=?', @reservation.startdate, @reservation.enddate,'Reserved', @currentCarId)
    @reservationsWithinInterval2 = Reservation.where('enddate between ? AND ? AND status = ? AND carid=?', @reservation.startdate, @reservation.enddate,'Reserved', @currentCarId)
    @reservationsWithinInterval3 = Reservation.where('startdate <= ? AND enddate >= ? AND status = ? AND carid=?', @reservation.startdate, @reservation.enddate,'Reserved', @currentCarId)
    #@reservationsWithinInterval3 = Reservation.where('startdate <= ? AND enddate >= ? AND status = ? AND carid=?', @reservation.startdate, @reservation.enddate,'Reserved', @currentCarId)

    if(!@currentUserOldReservation.nil?)
      flash[:notice] = 'One User can reserve one car at a time'
      redirect_to reservations_path
    elsif(@reservation.validateReservationDuration)
      flash[:notice] = 'Reservation duration should be between 1-10 hours'
      redirect_to reservations_path
    elsif (@reservationsWithinInterval1.count > 0 || @reservationsWithinInterval2.count>0 || @reservationsWithinInterval3.count>0)
      flash[:notice] = 'Select different time. Car already reserved in this time'
      redirect_to new_reservation_path(:reservation_carID => @currentCarId)
    elsif @reservation.save
      @car = Car.find_by(id: @currentCarId)
      @car.save
      redirect_to reservations_path
    else
      flash[:notice] = 'Some error occured while saving reservation. Please try again'
      redirect_to new_reservation_path(:reservation_carID => @currentCarId)
    end

  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cancel
    @reservation = Reservation.find_by(id: params[:id])
    @reservation.update(status: "Cancelled")
    @reservation.save
    @car = Car.find_by(id: @reservation.carid)
    @car.update(carstatus: :Available)
    @car.save
    redirect_to reservations_path
  end

  def checkout
    @reservation = Reservation.find_by(id: params[:id])
    if @reservation.startdate > Time.now #&& @reservation.status == "CheckedOut"
        flash[:notice] = 'Car cannot be checked out before reservation start time.'
        redirect_to reservations_path
    else
      @reservation.update(status: "CheckedOut")
      @reservation.save
      @car = Car.find_by(id: @reservation.carid)
      @car.update(carstatus: :CheckedOut)
      @car.save
      redirect_to reservations_path
    end
  end

  def return
    @reservation = Reservation.find_by(id: params[:id])
    @reservation.update(status: "Returned")
    @reservation.save
    @car = Car.find_by(id: @reservation.carid)
    @car.update(carstatus: :Available)
    @car.save
    redirect_to reservations_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:startdate, :enddate, :carid, :userid, :status)
    end
end
