Rails.application.routes.draw do
	resources :invoices
	root 'homepage#index'

	resources :line_items
	resources :renting_phases
	resources :contracts
	get 'generate_contract_form' => 'contracts#new_contract_form'
	post 'generate_contract' => 'contracts#generate_contract' 
	post 'generate_renting_phase' => 'renting_phases#generate_renting_phase'
	post 'generate_invoices' => 'invoices#generate_invoices'
	get 'invoices_list' => 'invoices#invoices_list'
	get 'items' => 'line_items#items'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
