require 'sinatra'					# Load server gem
require './contact'					# Gain access to relevant ruby files

get '/' do
	@crm_app_name = "Nic's CRM"		# To be passed along to view
	erb :index						# Links to HTML (erb) index file
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Nicholas", "Haley", "nicholaswilliamhaley@gmail.com", "Student")
	@contacts << Contact.new("Kristel", "Tang", "Unknown", "Student")
	@contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
	@contacts << Contact.new("Lord", "Voldemort", "dieharry@haggrid.com", "Dark Lord")

	erb :contacts
end

get '/contacts/new' do

end