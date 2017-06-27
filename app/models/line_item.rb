class LineItem < ApplicationRecord
	belongs_to :invoice

	def self.new_line_item(params)
  		@last_line_item = LineItem.last  # Check if the last line item exist 
		@new_line_item_id = @last_line_item ? @last_line_item.id + 1:1 # if last line item exist id plus one else id = 1
		# Generate new line item and save
		@new_line_item = LineItem.new(:id => @new_line_item_id, :start_date => params[:start_date], :end_date => params[:end_date], :unit_price => params[:unit_price], :units => params[:units], :total => params[:total], :invoice_id => params[:invoice_id])
		@new_line_item.save
	end
end
