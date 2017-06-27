class RentingPhase < ApplicationRecord
	belongs_to :contract
    # Generate renting phase method
    def self.new_renting_phase(params_renting_phase)
    	@last_renting_phase = RentingPhase.last 
  		# Check if the last contract exist 
		@new_renting_phase_id = @last_renting_phase ? @last_renting_phase.id + 1:1 # if last contract exist id plus one else id = 1
		# Generate new contract and save
		Rails.logger.debug("#{@new_renting_phase_id}")
		@renting_phase = RentingPhase.new(:id => @new_renting_phase_id, :start_date => params_renting_phase[:start_date], :end_date => params_renting_phase[:end_date], :price => params_renting_phase[:price], :cycles => params_renting_phase[:cycles], :contract_id => params_renting_phase[:contract_id])
		@renting_phase.save
	end
end
