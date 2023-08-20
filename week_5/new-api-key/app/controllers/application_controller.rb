class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

private

def record_not_found
  flash[:error] = "Record not found."
  redirect_to keys_path
end

end
