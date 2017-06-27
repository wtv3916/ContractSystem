class RentingPhasesController < ApplicationController
  before_action :set_renting_phase, only: [:show, :edit, :update, :destroy]

  # GET /renting_phases
  # GET /renting_phases.json
  def index
    @renting_phases = RentingPhase.all
  end

  # GET /renting_phases/1
  # GET /renting_phases/1.json
  def show
  end

  # GET /renting_phases/new
  def new
    @renting_phase = RentingPhase.new
  end

  # GET /renting_phases/1/edit
  def edit
  end

  # POST /renting_phases
  # POST /renting_phases.json
  def create
    @renting_phase = RentingPhase.new(renting_phase_params)

    respond_to do |format|
      if @renting_phase.save
        format.html { redirect_to @renting_phase, notice: 'Renting phase was successfully created.' }
        format.json { render :show, status: :created, location: @renting_phase }
      else
        format.html { render :new }
        format.json { render json: @renting_phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /renting_phases/1
  # PATCH/PUT /renting_phases/1.json
  def update
    respond_to do |format|
      if @renting_phase.update(renting_phase_params)
        format.html { redirect_to @renting_phase, notice: 'Renting phase was successfully updated.' }
        format.json { render :show, status: :ok, location: @renting_phase }
      else
        format.html { render :edit }
        format.json { render json: @renting_phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # Generate renting phase
  def generate_renting_phase
    #Get the start date and end date
    # @start_date = Date.new params[:renting_phase]["start_date(1i)"].to_i, params[:renting_phase]["start_date(2i)"].to_i, params[:renting_phase]["start_date(3i)"].to_i
    # @end_date = Date.new params[:renting_phase]["end_date(1i)"].to_i, params[:renting_phase]["end_date(2i)"].to_i, params[:renting_phase]["end_date(3i)"].to_i 
    @start_date = params[:renting_phase][:start_date]
    @end_date = params[:renting_phase][:end_date]


    @contract_id = params[:contract_id] 
    # Make sure end date is after start date
    @diff_date = @end_date.to_time - @start_date.to_time
    @test = @end_date
    Rails.logger.debug("#{@diff_date}")
    if @diff_date > 0
      # Get all the params from the generate form 
      params_renting_phase = {:start_date => @start_date, :end_date => @end_date, :price => params[:renting_phase][:price], :cycles => params[:renting_phase][:cycles], :contract_id => @contract_id}
      # Check if all of the params are present  
      if params_renting_phase.present?
        renting_phase = RentingPhase.new_renting_phase(params_renting_phase)
      end
      if renting_phase
        redirect_to "/contracts/#{@contract_id}"
        flash[:success] = 'Renting Phase was successfully created.'
      else
        redirect_to "/contracts/#{@contract_id}"
        flash[:notice] = 'Oops, something wrong, please try again!'
      end
    else
      redirect_to "/contracts/#{@contract_id}"
      flash[:alert] = 'Oops, end date is ealier than start date, please try again!'
    end
  end

  # DELETE /renting_phases/1
  # DELETE /renting_phases/1.json
  def destroy
    @renting_phase.destroy
    respond_to do |format|
      format.html { redirect_to renting_phases_url, notice: 'Renting phase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_renting_phase
      @renting_phase = RentingPhase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def renting_phase_params
      params.require(:renting_phase).permit(:start_date, :end_date, :price, :cycles, :contract_id)
    end
  end
