require 'json'

class ApiKey 


    # class variables -->

    @@api_keys_hash = {}

    # <--

    # class methods  ------> 

    def self.generate_key

       key = ApiKey.new
       @@api_keys_hash[key.key_name] = key
       "New API Key Generated : #{key.key_name}"

    end

    def self.get_random_key 

        eligible_keys_name = @@api_keys_hash.select { |k, v| !v.blocked }.keys
        key_name = eligible_keys_name.sample
        response = {}
        if key_name
            @@api_keys_hash[key_name].block_key
            response[:status] = 200
            response[:body] = "Here's your key : #{key_name}"
        else
            response[:status] = 400
            response [:body] = "ERROR: No eligible key"
        end
        response

    end

    def self.unblock_key(key_name)

        response = {}
        if @@api_keys_hash.key?(key_name)
            @@api_keys_hash[key_name].unblock_key
            response[:status] = 200
            response[:body] = "key unblocked"
        else
        response[:status] = 400
        response [:body] = "ERROR: key not found"      
        end
        response

    end


    def self.delete_Key(key)

        response = {}
        if @@api_keys_hash.key?(key_name)
            @@api_keys_hash.delete(key_name)
            response[:status] = 200
            response[:body] = "key unblocked"
       else
        response[:status] = 400
        response [:body] = "ERROR: key not found"   
            
       end
       response
         
    end

    def self.keep_alive_key(key)

        response = {}
        if @@api_keys_hash.key?(key_name)
            @@api_keys_hash[key_name].keep_alive
            response[:status] = 200
            response[:body] = "time updated"
            
       else
        response[:status] = 400
        response [:body] = "ERROR: key not found"   
       end
       response

    end


    def self.get_all_keys
        keys = {}

        @@api_keys_hash.each do |k,v|
            
            keys[k] = {
                key: v.key_name,
                blocked: v.blocked,
                time_since_blocked: v.time_since_blocked,
                time_since_kept_alive: v.time_since_kept_alive
            }
        end

        JSON.pretty_generate(keys)
    end

    def self.keep_alive_status_check 

        loop do   
            @@api_keys_hash.each do |k,v|
                @@api_keys_hash.delete(k) if v.time_since_kept_alive + 40 < Time.now
            end
            sleep 40
        end
    end

    def self.blocked_status_check 
        loop do 
            @@api_keys_hash.each do |k,v|
                if v.blocked && v.time_since_blocked + 20 < Time.now
                    @@api_keys_hash[k].time_since_blocked = nil
                    @@api_keys_hash[k].blocked = false
                end
                
            end
            sleep 20   
        end
    end
    
    

    # <--------

   attr_reader :key_name
   attr_accessor :time_since_blocked, :time_since_kept_alive, :blocked

#   instance methods -----> 

    def initialize
      @key_name = generate_api_key
      @time_since_blocked = nil
      @time_since_kept_alive = Time.now
      @blocked = false
    end

    def generate_api_key(length = 5)
        characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
        api_key = (0...length).map { characters[rand(characters.length)] }.join
        api_key
    end
     
    def unblock_key
        @blocked = false
        @time_since_blocked = nil
    end

    def block_key
        @blocked = true
        @time_since_blocked = Time.now
    end

    def keep_alive
        @time_since_kept_alive = Time.now
    end

    # <---- 

        
end



