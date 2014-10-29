require 'sinatra'					# Load server gem
require './contact'					# Gain access to relevant ruby files
require './rolodex'

$rolodex = Rolodex.new

get '/' do
	@crm_app_name = "the Bitmaker CRM"		# To be passed along to view (index.erb)
	erb :index								# Links to HTML (erb) index file. Get explanation on this format
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	# Creates a new contact from the Contact class using the param input
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end