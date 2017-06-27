json.extract! line_item, :id, :start_date, :end_date, :unit_price, :unites, :total, :invoice_id, :created_at, :updated_at
json.url line_item_url(line_item, format: :json)
