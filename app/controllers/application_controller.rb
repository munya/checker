class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # def arrow_pass
  #   @arrow_pass ||= RestClient::Resource.new(
  #     Settings.arrow_pass_host,
  #     headers: {
  #       "APS-IDENTIFIER" => Settings.client.app_key
  #     }
  #   )
  # end

end
