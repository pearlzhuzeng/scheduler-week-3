require_relative '../../seed'
require_relative '../../controllers/providers_controller'
require_relative '../../lib/interface'
require_relative '../../lib/command_script_strategy'

RSpec.describe ProvidersController do
  describe '#add' do
    it 'adds a provider to the list' do
      command_script_strategy = CommandScriptStrategy.new([
        { 'Provider Name:' => 'Jason' },
        { 'Provider Phone Number:' => '5558889981' },
      ])

      ProvidersController.add(command_script_strategy)

      expect(Provider.find_provider_by_name('Jason').name).to eq ('Jason')
    end
  end

  describe '#remove' do
    it 'removes a provider from the list' do
      command_script_strategy = CommandScriptStrategy.new([
        { 'Provider Name To Remove:' => 'Sue' },
        {'(y/n):' => 'y'},
      ])

      ProvidersController.remove(command_script_strategy)
      
      expect(Provider.find_provider_by_name('Jim').name).to eq ('Jim')
      expect(Provider.find_provider_by_name('Sue')).to be (false)
    end
  end
end