require 'pry'
require_relative '../../seed'
require_relative '../../controllers/services_controller'
require_relative '../../lib/interface'
require_relative '../../lib/command_script_strategy'

RSpec.describe ServicesController do
  describe '#add' do
    it 'adds a service to the services list' do
      $input_strategy = CommandScriptStrategy.new([
                                                      { 'Service Name:' => 'Fortune Telling' },
                                                      { 'Service Price:' => '100' },
                                                      {'Service Length (Mins):' => '90'}
                                                  ])

      ServicesController.add
      expect(Service.find_service_by_name('Fortune Telling')).not_to be nil
    end
  end

  describe '#remove' do
    it 'removes a service from the services list' do
      $input_strategy = CommandScriptStrategy.new([
                                                      { 'Service Name:' => 'High Five' },
                                                      { 'Service Price:' => '100' },
                                                      {'Service Length (Mins):' => '90'}
                                                  ])

      ServicesController.add
      $input_strategy = CommandScriptStrategy.new([
                                                      { 'Service Name:' => 'Not High Five' },
                                                      { 'Service Price:' => '100' },
                                                      {'Service Length (Mins):' => '90'}
                                                  ])

      ServicesController.add
      $input_strategy = CommandScriptStrategy.new([
                                                      { 'Service Name:' => 'High Five' }
                                                      ])

      ServicesController.remove
      expect(Service.find_service_by_name('High Five')).to be nil
      expect(Service.find_service_by_name('Not High Five')).to_not be nil
    end
  end
end