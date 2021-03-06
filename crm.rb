require 'sinatra'					# Load server gem
require 'sinatra/reloader'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial			#Serial: An integer that automatically increments
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

# Main Menu
get '/' do
	@crm_app_name = "the Bitmaker CRM"		# To be passed along to view (index.erb)
	erb :index								# Links to HTML (erb) index file. Get explanation on this format
end

# All contacts page
get '/contacts' do
	@contacts = Contact.all 				# Store all Contacts in @contacts var
	erb :contacts
end

# Add a contact page
get '/contacts/new' do
	erb :new_contact
end

# Add a contact post
post '/contacts' do
	# Creates a new contact from the Contact class using the param input
	new_contact = Contact.create(
		:first_name => params[:first_name], 
		:last_name => params[:last_name], 
		:email => params[:email], 
		:note => params[:note]
		)
	redirect to('/contacts')
end

# Search menu page
get '/contacts/search' do	
	erb :search_menu
end

# Takes input id parameter from search page and brings user to that contact
post '/contacts/search' do
	@contact = Contact.get(params[:id].to_i)		
	if @contact
		redirect to("/contacts/#{@contact.id}")
	else
		raise Sinatra::NotFound
	end
end

# Specific contact page
get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)		
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id/edit" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do								# This is to record and send modified info to the server
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.update(:first_name => params[:first_name])
		@contact.update(:last_name => params[:last_name])
		@contact.update(:email => params[:email])
		@contact.update(:note => params[:note])

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

delete "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.destroy
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end












