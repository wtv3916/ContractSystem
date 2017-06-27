class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    #get the renting phase
    @renting_phases = RentingPhase.where(contract_id: params[:id]).order(start_date: :ASC)
    # Check if generate the invoices successfully
    if @renting_phases.present?
      @invoices_check = Invoice.where(renting_phase_id: @renting_phases.last.id)
    end
    # Calculate the max cycles month according to the Contract
    @max_cycles = (@contract.end_date - @contract.start_date)/1.month + 1
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Gemerate /new_contract
  def new_contract_form  
  end

  # Generate Contract
  def generate_contract
    #Get the start date and end date
    @start_date = Date.new params[:contract]["start_date(1i)"].to_i, params[:contract]["start_date(2i)"].to_i, params[:contract]["start_date(3i)"].to_i
    @end_date = Date.new params[:contract]["end_date(1i)"].to_i, params[:contract]["end_date(2i)"].to_i, params[:contract]["end_date(3i)"].to_i 
    # Get all the params from the generate form  
    params_contract = {:title => params[:contract][:title], :renter => params[:contract][:renter], :start_date => @start_date, :end_date => @end_date}
    # Check if all of the params are present  
    if params_contract.present?
      new_contract = Contract.generate_contract(params_contract)
    end
    if new_contract
      redirect_to contracts_path
      flash[:success] = 'Contract was successfully created.'
    else
      redirect_to generate_contract_form_path
      flash[:notice] = 'Oops, something wrong, please try again!'
    end
  end

  # Generate invoices
  def generate_invoices

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:title, :renter, :start_date, :end_date)
    end
  end
