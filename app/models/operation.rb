class Operation < ActiveRecord::Base
  attr_reader :arrow_pass
  
  after_create :run_operation
  
  def get_events(options)
    response = arrow_pass["/api/device/events/#{options['event_id']}.json"].get
    
    json = JSON.parse(response.body)
    
    event = Event.find_or_initialize_by(id: json["id"])
    event.options = json
    event.save
  end

  def destroy_events(options)
    event = Event.find_by(id: options["event_id"])
    if event.present?
      event.destroy
    end
  end
  
  def get_white_lists(options)
    true
  end  
    
  private
  
  def run_operation
    if send(function_name.to_s, options)
      #send success for operation
      response = arrow_pass["/api/device/operations/#{ap_id}/processed.json"].post('')
    else
      #send fail for operation
      response = arrow_pass["/api/device/operations/#{ap_id}/failed.json"].post('')
    end    
  end  
  
  def arrow_pass
    @arrow_pass ||= RestClient::Resource.new(
      Settings.arrow_pass_host,
      headers: {
        "APS-IDENTIFIER" => Settings.client.app_key
      }
    )
  end  
  
end
