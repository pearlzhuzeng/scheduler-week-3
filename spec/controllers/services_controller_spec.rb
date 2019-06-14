require_relative '../../seed'
require_relative '../../controllers/services_controller'
require_relative '../../lib/interface'
require_relative '../../lib/command_script_strategy'

RSpec.describe ServicesController do
  describe '#add' do
    # it 'adds a service to the services list' do
    #   $input_strategy = CommandScriptStrategy.new([
    #                                                   { 'Service Name:' => 'Fortune Telling' },
    #                                                   { 'Service Price:' => '100' },
    #                                                   {'Service Length (Mins):' => '90'},
    #                                                   {"Add to which provider?:" => 'Sue'},
    #                                               ])

    #   ServicesController.add
    #   expect(Service.find_service_by_name('Fortune Telling').name).to eq ('Fortune Telling')
    # end

    it 'adds a service to a provider' do
      $input_strategy = CommandScriptStrategy.new([
                                                      { 'Service Name:' => 'Magic Tricks' },
                                                      { 'Service Price:' => '100' },
                                                      {'Service Length (Mins):' => '90'},
                                                      {"Add to which provider?:" => 'Sue'},
                                                  ])

      ServicesController.add
      expect(Provider.find_provider_by_service('Magic Tricks').length).to eq (1)
      expect(Provider.find_provider_by_service('Magic Tricks').first.name).to eq ('Sue')
    end
  end

  describe '#remove' do
    it 'removes a service from a provider' do
      $input_strategy = CommandScriptStrategy.new([
                                                      { 'Service Name:' => 'Fortune Telling' },
                                                      {'Service Provider:' => 'Sue'},
                                                  ])

      ServicesController.remove

      expect(Provider.find_provider_by_name('Sue').contains_service?('Fortune Telling')).to be(false)
    end
  end
end