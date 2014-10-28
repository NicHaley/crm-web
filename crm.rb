require 'sinatra'					# Load server gem
require './contact'					# Gain access to relevant ruby files
require './rolodex'

$rolodex = Rolodex.new

get '/' do
	@crm_app_name = "Nic's CRM"		# To be passed along to view
	erb :index						# Links to HTML (erb) index file
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do

end