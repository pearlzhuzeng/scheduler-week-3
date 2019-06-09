require_relative '../../controllers/providers_controller'
require_relative '../../lib/interface'
require_relative '../../lib/command_script_strategy'

RSpec.describe ProvidersController do
  describe '#add' do
    it 'adds a provider to the list' do
      $all_providers = []

      command_script_strategy = CommandScriptStrategy.new([
        { 'Please enter a command:' => 'sp:add' },
        { 'Provider Name:' => 'Jason' },
        { 'Provider Phone Number:' => '555' },
        { 'Please enter a command:' => 'exit' },
      ])

      interface = Interface.new(command_script_strategy)
      interface.start

      expect(ProviderHelper.new.find_provider_by_name('Jason').name).to eq ('Jason')
    end
  end

  describe '#remove' do
    it 'removes a provider from the list' do
      $all_providers = [
        Provider.new('Jason', '1111111111', [Service.new('A', 200, 60)], [], []), 
        Provider.new('Yasmine', '1111111111', [Service.new('A', 200, 60)], [], []), 
        Provider.new('Kai', '1111111111', [Service.new('A', 200, 60)], [], [])
      ]

      command_script_strategy = CommandScriptStrategy.new([
        { 'Please enter a command:' => 'sp:remove' },
        { 'Provider Name To Remove:' => 'Kai' },
        {'(y/n):' => 'y'},
        { 'Please enter a command:' => 'exit' }
      ])

      interface = Interface.new(command_script_strategy)
      interface.start

      expect(ProviderHelper.new.find_provider_by_name('Yasmine').name).to eq ('Yasmine')
      expect(ProviderHelper.new.find_provider_by_name('Kai')).to be (false)
    end
  end
end