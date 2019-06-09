class Appointment
  attr_reader :timeblock, :service, :client_name, :service_provider

  def initialize(timeblock, service, client_name, service_provider)
    @timeblock = timeblock
    @service = service
    @client_name = client_name
    @service_provider = service_provider
  end

  def print_details
    puts "Provider Name: #{Magenta}#{@service_provider.name}#{Reset}, Client Name: #{Cyan}#{@client_name}#{Reset}, Service Name: #{Yellow}#{@service.name}#{Reset}"
    puts "Date: #{Green}#{@timeblock.month}/#{@timeblock.day}/#{@timeblock.year}#{Reset} - Start: #{Green}#{@timeblock.start_time.strftime("%T")}#{Reset}, Stop: #{Green}#{@timeblock.end_time.strftime("%T")}#{Reset}"
    puts "----------------------------------------------------------------------"
  end
end