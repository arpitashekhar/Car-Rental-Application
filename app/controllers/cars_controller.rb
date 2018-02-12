class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    #@cars = Car.where("location LIKE ?", "%#{params[:search ]}%")
    #Fetch all reservations, update their status and car status respectively
    @reservations = Reservation.all
    @reserved = false
    @reservations.each do |reservation|
      if(reservation.status == "Reserved" && reservation.userid == current_user.id)
        @reserved = true
      end
      if reservation.startdate + 30.minutes < Time.now && reservation.status = "Reserved"
        reservation.update(status: "Cancelled")
        reservation.save
        @car = Car.find_by(id: reservation.carid)
        if @car != nil
          @car.update(carstatus: :Available)
          @car.save
        end
      end
      if reservation.enddate < Time.now && reservation.status == "CheckedOut"
        reservation.update(status: "Returned") #Car made available by system
        #Send notification to user
        reservation.save
        if @car != nil
          #@car = Car.find_by(id: reservation.carid)
          @car.update(carstatus: :Available)
          @car.save
        end
      end
      if reservation.enddate > Time.now && reservation.startdate<Time.now && (reservation.status == "Reserved" || reservation.status == "CheckedOut")
        if @car != nil
          #@car = Car.find_by(id: reservation.carid)
          @car.update(carstatus: reservation.status)
          @car.save
        end
      end
    end
    if (current_user.superadmin_role? || current_user.supervisor_role?)
      @cars=Car.all
    else
      @cars = Car.where(:active => "Active")
    end
    @reservation = Hash.new
    @cars.each do |car|
      if car.carstatus != 'Available'
        @oldReservation = Reservation.where(carid: car.id)
        @oldReservation.select do |r|
          r.status != "Cancelled" && r.status != "Returned"
        end
        if @oldReservation != nil && @oldReservation.count > 0
          @reservation[car.id] = @oldReservation[0].userid
          puts @reservation[car.id]
        end
      end
  end
end
  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to cars_path}
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to cars_path, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
#check if you are using this
  def search
    searchparams = params[:q] #id
    @cars = Car.where("model LIKE ? OR manufacturer LIKE ? OR style LIKE ? OR status LIKE ?", "%#{searchparams}%","%#{searchparams}%","%#{searchparams}%", "%#{searchparams}%")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:name, :model, :manufacturer, :hourly_rate, :style, :license, :location, :carstatus, :active )
      #params.require(:recipe).permit(:title, :description, :instructions, :category_id)
    end
end
