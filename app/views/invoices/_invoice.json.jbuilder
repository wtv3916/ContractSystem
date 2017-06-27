json.extract! invoice, :id, :start_date, :end_date, :due_date, :total, :contract_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
