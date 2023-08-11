require 'sinatra'
require_relative 'keys'


configure do
    set :blocked_status_thread, Thread.new { ApiKey.blocked_status_check }
    set :keep_alive_status_thread, Thread.new { ApiKey.keep_alive_status_check }  
end


get '/' do
    content_type :json
  ApiKey.get_all_keys
end


get '/generate-key' do
    response= ApiKey.generate_key  
    
end


get '/get-key' do
    response=ApiKey.get_random_key 
    if response[:status]==200
        response[:body]
    else
    halt response[:status], response[:body]
    end
    

end


get '/unblock-key/:key' do
    response= ApiKey.unblock_key(params[:key])
    if(response[:status]==200)
        response[:body]
    else
    halt response[:status], response[:body]
    end
end


get '/delete-key/:key' do
    response=ApiKey.delete_key(params[:key])
    if(response[:status]==200)
        response[:body]
    else
    halt response[:status], response[:body]
    end
end


get '/keep-alive/:key' do
    ApiKey.keep_alive_key(params[:key])
    if(response[:status]==200)
        response[:body]
    else
    halt response[:status], response[:body]
    end
end


get '/*' do
    halt 404, "ERROR: Route not found"
end




   









