class Invoice < ApplicationRecord
	belongs_to :renting_phase
	has_many :line_items, dependent: :destroy

	def self.new_invoice(invoice_params)
		@last_invoice = Invoice.last  # Check if the last invoice exist 
		@new_invoice_id = @last_invoice ? @last_invoice.id + 1:1 # if last invoice exist id plus one else id = 1
		# Generate new invoice and save
		@new_invoice = Invoice.new(:id => @new_invoice_id, :start_date => invoice_params[:start_date], :end_date => invoice_params[:end_date], :due_date => invoice_params[:due_date], :total => invoice_params[:total], :renting_phase_id => invoice_params[:renting_phase_id])
		@new_invoice.save
		# Create the params to the modal		
		line_item_params = {:start_date => invoice_params[:start_date], :end_date => invoice_params[:end_date], :unit_price => invoice_params[:unit_price], :units => invoice_params[:units], :total => invoice_params[:total], :invoice_id => @new_invoice_id}
		@new_line_item = LineItem.new_line_item(line_item_params)
	end

	# Get the due date	
	def self.due_date(start_date)
		@start_date = start_date
		@due_year = @start_date.strftime("%Y").to_i
		@due_month = @start_date.strftime("%m").to_i - 1
		@due_date = Date.new(@due_year, @due_month, 15)	
		return @due_date
	end
end
