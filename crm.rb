require 'sinatra'					# Load server gem
require 'sinatra/reloader'
require './contact'					# Gain access to relevant ruby files
require './rolodex'
require 'pry'

$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))
$rolodex.add_contact(Contact.new("Nic", "Haley", "nicholaswilliamhaley@gmail.com", "Student"))

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

get "/contacts/:id" do
	@contact = $rolodex.find(params[:id].to_i)		# Input param ID comes from URL input
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id/edit" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

# Search a contact page
# get '/contacts/search' do
# 	if params[:id]
# 		id_input = (params[:id].to_i)
# 		@contact = $rolodex.find(id_input)
# 		if @contact
# 			redirect to("/contacts/#{@contact.id}")
# 		else
# 			@error = "Contact ##{id_input} not found"
# 		end
# 		erb :search_menu
# 	else
# 		erb :search_menu
# 	end
# end

# # Display searched contact page
# get '/contacts/:id' do
# 	@contact = $rolodex.find_contact(params[:id].to_i)
# 	erb :show_contact
# end














