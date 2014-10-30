require 'sinatra'					# Load server gem
require './contact'					# Gain access to relevant ruby files
require './rolodex'
require 'pry'

$rolodex = Rolodex.new

# Main Menu
get '/' do
	@crm_app_name = "the Bitmaker CRM"		# To be passed along to view (index.erb)
	erb :index								# Links to HTML (erb) index file. Get explanation on this format
end

# All contacts page
get '/contacts' do
	erb :contacts
end

# Add a contact page
get '/contacts/new' do
	erb :new_contact
end

# Add a contact post
post '/contacts' do
	# Creates a new contact from the Contact class using the param input
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

# Search a contact page
get '/contacts/search' do
	erb :search_menu
end

# Search a contact post
post '/contacts/search' do							# Not sure if this is correct
	id_input = (params[:id].to_i)
	@contact = $rolodex.find_contact(id_input)
	if @contact
		redirect to("/contacts/#{@contact.id}")
	else
		raise Sinatra::NotFound
	end
end

# Display searched contact page
get '/contacts/:id' do
	@contact = $rolodex.find_contact(params[:id].to_i)
	erb :show_contact
end