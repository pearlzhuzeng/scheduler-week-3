require 'tty-prompt'
require_relative '../seed'

require_relative '../controllers/appointments_controller'
require_relative '../controllers/availabilities_controller'
require_relative '../controllers/providers_controller'
require_relative '../controllers/services_controller'
require_relative './prompt_input_strategy'

class Interface
  FUNCTION_LOOKUP = {
		"Add a provider" => {
			controller: ProvidersController,
      method_name: :add
		},
		"Remove a provider" => {
			controller: ProvidersController,
      method_name: :remove
    },
		"Update provider information" => {
				controller: ProvidersController,
				method_name: :update
		},
    "Display all providers" => {
      controller: ProvidersController,
      method_name: :index,
    },
		"Add a service" => {
			controller: ServicesController,
			method_name: :add
		},
		"Remove a service" => {
			controller: ServicesController,
			method_name: :remove
    },
    "Display all services" => {
      controller: ServicesController,
      method_name: :index
    },
    "Add an availability to a provider's list of availabilities" => {
      controller: AvailabilitiesController,
      method_name: :add
    },
		"Schedule an appointment" => {
			controller: AppointmentsController,
			method_name: :add
    },
		"View the schedule of a particular provider" => {
			controller: ProvidersController,
			method_name: :view_schedule
		}
  }

  def initialize(input_strategy)
    @input_strategy = input_strategy
  end
  
  def start
    continue_program = true

    while continue_program do
      choice = @input_strategy.select("What would you like to do?", FUNCTION_LOOKUP.keys)
      FUNCTION_LOOKUP[choice][:controller].send(FUNCTION_LOOKUP[choice][:method_name])
    end
	end
end