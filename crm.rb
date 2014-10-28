require 'sinatra'

get '/' do
	@crm_app_name = "Nic's CRM"		#To be passed along to view
	erb :index
end