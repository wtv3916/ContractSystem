class Contract < ApplicationRecord
	has_many :renting_phases, dependent: :destroy
	
	def self.generate_contract(contract_params)
		@last_contract = Contract.last  # Check if the last contract exist 
		@new_contract_id = @last_contract ? @last_contract.id + 1:1 # if last contract exist id plus one else id = 1
		# Generate new contract and save
		@contract = Contract.new(:id => @new_contract_id, :title => contract_params[:title], :renter => contract_params[:renter], :start_date => contract_params[:start_date], :end_date => contract_params[:end_date])
		@contract.save
	end

	def self.generate_invoices(contract_id)
		@contract_id = contract_id
		@contract = Contract.find(@contract_id)
		@renting_phases = RentingPhase.all.order(start_date: :ASC)
		if @renting_phases.present?
			@renting_phases.each do |r|
				# determin how often will the renter pay
				@cycles = r.cycles
				# Calculate how many invoices per renting phase
				@invoices_pay_num = ((r.end_date - r.start_date + 1.day)/@cycles.month).to_i
				Rails.logger.debug("#{@invoices_pay_num}")
				# Calculate the numbers of days which less than a month
				@invoices_day_num = (((r.end_date - r.start_date + 1.day) % @cycles.month)/1.day).to_i
				# if the renting phase is less than a month
				if @invoices_pay_num == 0 && @invoices_day_num != 0
					@invoices = Invoice.where(renting_phase_id: r.id).order(start_date: :ASC)
			       # Calculate the unit price
			       @unit_price = BigDecimal.new((r.price * 12 / 365).round(2))
				   # Calculate the total price
				   @total_num = @unit_price * @invoices_day_num
				   @total = BigDecimal.new(@total_num.round(2))	
				   # Get the due date
				   @due_date = Invoice.due_date(r.start_date)
				   # Create the params to the modal		
				   invoice_params = {:start_date => r.start_date, :end_date => r.end_date, :due_date => @due_date, :total => @total, :renting_phase_id => r.id, :unit_price => @unit_price, :units => @invoices_day_num}
				   @new_invoice = Invoice.new_invoice(invoice_params)
				   # if the renting phase is more than a month			
				elsif @invoices_pay_num >= 1 
				   # Calculate the unit price
				   @unit_price = r.price
				   @i = 1
				   while @i <= @invoices_pay_num
				   	@invoices = Invoice.where(renting_phase_id: r.id).order(start_date: :ASC)
				   	if @invoices.present?
				   		@start_date = @invoices.last.end_date + 1.day
				   		@end_date = @start_date + @cycles.month - 1.day
				   		@i +=1
				   	else
				   		@start_date = r.start_date
				   		@end_date = @start_date + @cycles.month - 1.day
				   		@i +=1
				   	end
				    	# Get the due date
				    	@due_date = Invoice.due_date(@start_date)	
				        # Calculate the total price
				        @total_num = r.price * @cycles
				        @total = BigDecimal.new(@total_num.round(2))
				        invoice_params = {:start_date => @start_date, :end_date => @end_date, :due_date => @due_date, :total => @total, :renting_phase_id => r.id, :unit_price => @unit_price, :units => @cycles}
				        @new_invoice = Invoice.new_invoice(invoice_params)
				    end
				    # There are some extra sigle days
				    if @invoices_day_num != 0 
				    # Calculate the unit price
				    @unit_price = BigDecimal.new((r.price * 12 / 365).round(2))
				    @invoices = Invoice.where(renting_phase_id: r.id).order(start_date: :ASC)
				    if @invoices.present?
				    	@start_date = @invoices.last.end_date + 1.day
				    	@end_date = r.end_date
				    		# Get the due date
				    		@due_date = Invoice.due_date(@start_date)	
				    		# Calculate the total price
				    		@total_num = @unit_price * @invoices_day_num
				    		@total = BigDecimal.new(@total_num.round(2))		
				    		invoice_params = {:start_date => @start_date, :end_date => @end_date, :due_date => @due_date, :total => @total, :renting_phase_id => r.id, :unit_price => @unit_price, :units => @invoices_day_num}
				    		@new_invoice = Invoice.new_invoice(invoice_params)
				    	end
				    end

				end
			end
		end
	end
end
